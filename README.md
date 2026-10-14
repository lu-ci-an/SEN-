# Scientific calculator

A React, TypeScript, Next.js and CSS web rebuild inspired by my original school calculator project.

## Web application

The standalone app lives in `web/` and includes sequential arithmetic, powers, trigonometric functions, degree/radian modes, logarithms, square roots, squares, reciprocals, factorials, percentages and constants. It supports keyboard input, invalid-input errors and recall of the last eight results.

Calculations run in the browser. History resets on reload. Arithmetic is sequential, like a handheld calculator: `2 + 3 * 4 =` produces `20`. Percent divides the current value by 100. Results use JavaScript floating-point arithmetic and display up to 12 significant digits.

### Run locally

Use Node.js 22.13 or newer:

```sh
cd web
npm ci
npm run dev
```

Open http://localhost:3000. Select the calculator to use numbers, `+`, `-`, `*`, `/`, `^`, Enter, Backspace and Escape. Enter activates a focused button normally.

### Test and build

```sh
npm test
npm run build
npm start
```

For Next.js hosting, set the project root to `web`. No environment variables or database are needed. This repository does not yet have a verified public deployment of the web rebuild.

## Original school project

The root `lib/`, `test/`, `pubspec.yaml` and `pubspec.lock` preserve the original Flutter/Dart school project. The web rebuild is independent and does not require Flutter.

The portfolio also includes the calculator at `/projects/calculator`.
