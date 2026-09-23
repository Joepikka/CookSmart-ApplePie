# CookSmart — Apple Pie Scroll Edition

An **independent copy** of CookSmart featuring an alternative apple-pie hero animation.

- **Source:** A single six-second apple-pie video provided by the project owner.
- **Desktop:** 96 WebP frames (1280×720, 16 fps, ~2.46 MiB).
- **Mobile:** 84 WebP frames (540×960, 14 fps, ~0.61 MiB), with the whole 16:9 scene kept visible in a cream portrait composition.
- **Technology:** React, Vite, TypeScript, GSAP ScrollTrigger and Canvas.
- **Interaction:** Scroll forward or backward to assemble or deconstruct the pie; mobile loads only mobile frames.
- **Accessibility:** Reduced-motion and data-saver visitors get an image poster and working recipe CTA.

This standalone repository was copied from the CookSmart cinematic-preview code before being redesigned; **the original CookSmart repository and its kitchen preview remain unchanged**. The full recipe dataset, pictures, saved collection and recipe dialogs are included.

Local development: `npm ci && npm run dev` (port 5173, use 5174 if another version is running).

GitHub Pages deployment: `npm run build -- --mode pages`. The GitHub Actions workflow publishes the output automatically when `main` changes.
