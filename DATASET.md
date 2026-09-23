# Imported recipe collection

Source: user-provided `archive.zip`, imported September 15, 2026.

- Source rows: 13,501; source JPGs: 13,582.
- Imported: 13,463 complete recipes with matching photos.
- Excluded: 38 rows missing title, ingredients, instructions, or a matching image. Details in `dataset-import-report.json`.
- Original ten curated previews remain, giving 13,473 total entries.
- No cuisine, cooking-time, or serving-count fields were supplied. Times and yields are left unknown; the full dataset is not labeled American-only. Category groupings use title keywords and may be imperfect.

## Storage and behavior

`public/dataset/index.json` is a searchable metadata index, fetched separately from the application bundle. Complete quantities and directions load on demand from 136 JSON chunks. Photos are stored locally under `public/dataset/images` with stable numeric filenames. Existing curated recipe IDs remain unchanged; imported IDs are 100000 plus the original CSV row position.

The UI renders 24 cards initially, with a Show more button. Search supports multiple words across names and ingredients. Complete recipe content renders as text, never HTML or executable code.

## Reimport

Run `./import-dataset.ps1 -ZipPath <path>` and then `node prepare-dataset.mjs` from the site directory. The importer reads the named CSV and copies only matched JPG entries to controlled numeric output paths. It never extracts arbitrary archive paths or evaluates Python-like ingredient lists. Reimporting the same archive preserves recipe identifiers.

Validation checked every imported ID, photo path, detail record, ingredient list, and instruction list: zero missing assets or empty details.
