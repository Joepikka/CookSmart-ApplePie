param([string]$ZipPath = 'C:\Users\joepi\Downloads\archive.zip')
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$assetRoot = Join-Path $PSScriptRoot 'public/dataset'
New-Item -ItemType Directory -Force -Path "$assetRoot/images", "$PSScriptRoot/.sites-runtime" | Out-Null
$archive = [System.IO.Compression.ZipFile]::OpenRead($ZipPath)
try {
  $entry = $archive.GetEntry('Food Ingredients and Recipe Dataset with Image Name Mapping.csv')
  if (!$entry) { throw 'Expected recipe CSV is missing.' }
  $reader = [System.IO.StreamReader]::new($entry.Open())
  try { $rows = @($reader.ReadToEnd() | ConvertFrom-Csv) } finally { $reader.Dispose() }
  $valid = [System.Collections.Generic.List[object]]::new()
  $excluded = [System.Collections.Generic.List[object]]::new()
  for ($i = 0; $i -lt $rows.Count; $i++) {
    $row = $rows[$i]
    $photo = $archive.GetEntry('Food Images/Food Images/' + $row.Image_Name + '.jpg')
    if (!$row.Title -or !$row.Ingredients -or !$row.Instructions -or !$photo) {
      $excluded.Add(@{row=$i;title=$row.Title;reason='Missing title, ingredients, instructions, or matching image'})
      continue
    }
    $id = 100000 + $i
    $output = [System.IO.File]::Create("$assetRoot/images/$id.jpg")
    $inputStream = $photo.Open()
    try { $inputStream.CopyTo($output) } finally { $inputStream.Dispose(); $output.Dispose() }
    $valid.Add(@{id=$id;title=$row.Title;ingredients=$row.Ingredients;instructions=$row.Instructions;cleaned=$row.Cleaned_Ingredients;imageName=$row.Image_Name})
  }
  $valid | ConvertTo-Json -Depth 4 -Compress | Set-Content -Encoding utf8 "$PSScriptRoot/.sites-runtime/import-rows.json"
  @{total=$rows.Count;imported=$valid.Count;excluded=$excluded} | ConvertTo-Json -Depth 5 | Set-Content -Encoding utf8 "$PSScriptRoot/dataset-import-report.json"
  Write-Output "Imported $($valid.Count) recipes with photos; excluded $($excluded.Count) incomplete entries."
} finally { $archive.Dispose() }
