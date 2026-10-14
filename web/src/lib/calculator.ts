export function calculate(a: number, b: number, operator: string): number {
  switch (operator) {
    case '+': return a + b;
    case '−': return a - b;
    case '×': return a * b;
    case 'xʸ': return a ** b;
    case '÷': return b === 0 ? NaN : a / b;
    default: return b;
  }
}

export function scientific(value: number, operation: string, degrees: boolean): number {
  const angle = degrees ? value * Math.PI / 180 : value;
  switch (operation) {
    case 'sin': return Math.sin(angle);
    case 'cos': return Math.cos(angle);
    case 'tan': return Math.abs(Math.cos(angle)) < 1e-12 ? NaN : Math.tan(angle);
    case 'log': return value > 0 ? Math.log10(value) : NaN;
    case 'ln': return value > 0 ? Math.log(value) : NaN;
    case '√x': return Math.sqrt(value);
    case 'x²': return value ** 2;
    case '1/x': return value === 0 ? NaN : 1 / value;
    case '%': return value / 100;
    case '±': return -value;
    case 'n!': {
      if (!Number.isInteger(value) || value < 0 || value > 170) return NaN;
      let result = 1;
      for (let i = 2; i <= value; i++) result *= i;
      return result;
    }
    default: return value;
  }
}

export function formatResult(value: number): string {
  if (!Number.isFinite(value)) return 'Error';
  return String(Number(value.toPrecision(12)));
}
