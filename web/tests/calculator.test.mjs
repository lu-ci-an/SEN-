import { test } from 'node:test';
import assert from 'node:assert/strict';
import { calculate, scientific, formatResult } from '../src/lib/calculator.ts';
const near = (actual, expected) => assert.ok(Math.abs(actual - expected) < 1e-10);
test('arithmetic and powers', () => {
  assert.equal(calculate(2, 3, '+'), 5);
  assert.equal(calculate(8, 3, '−'), 5);
  assert.equal(calculate(2, 3, '×'), 6);
  assert.equal(calculate(8, 2, '÷'), 4);
  assert.equal(calculate(2, 10, 'xʸ'), 1024);
});
test('degrees and radians', () => {
  near(scientific(30, 'sin', true), .5);
  near(scientific(Math.PI / 2, 'sin', false), 1);
  near(scientific(60, 'cos', true), .5);
});
test('logarithms and factorial boundaries', () => {
  assert.equal(scientific(100, 'log', true), 2);
  assert.equal(scientific(0, 'n!', true), 1);
  assert.equal(scientific(5, 'n!', true), 120);
  for (const input of [-1, 1.5, 171]) assert.equal(formatResult(scientific(input, 'n!', true)), 'Error');
});
test('invalid operations give errors', () => {
  assert.equal(formatResult(calculate(1, 0, '÷')), 'Error');
  assert.equal(formatResult(scientific(90, 'tan', true)), 'Error');
  assert.equal(formatResult(scientific(-1, '√x', true)), 'Error');
  assert.equal(formatResult(scientific(0, 'log', true)), 'Error');
});
test('display preserves small numbers and rounds floating-point noise', () => {
  assert.equal(formatResult(1e-15), '1e-15');
  assert.equal(formatResult(.1 + .2), '0.3');
});
