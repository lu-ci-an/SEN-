'use client';

import { useState, type KeyboardEvent } from 'react';
import { calculate, scientific, formatResult } from '@/lib/calculator';
import './calculator-project.css';

const keys = ['sin', 'cos', 'tan', 'log', 'ln', '√x', 'x²', '1/x', 'n!', 'π', 'xʸ', 'AC', '⌫', '%', '±', 'e', '7', '8', '9', '÷', '×', '4', '5', '6', '−', '+', '1', '2', '3', '0', '.', '='];

export default function CalculatorProject() {
  const [display, setDisplay] = useState('0');
  const [expression, setExpression] = useState('');
  const [operand, setOperand] = useState<number | null>(null);
  const [operator, setOperator] = useState('');
  const [fresh, setFresh] = useState(true);
  const [ready, setReady] = useState(false);
  const [degrees, setDegrees] = useState(true);
  const [history, setHistory] = useState<{ expression: string; result: string }[]>([]);
  const record = (expression: string, result: number) => {
    if (Number.isFinite(result)) setHistory(items => [{ expression, result: formatResult(result) }, ...items].slice(0, 8));
  };

  const press = (key: string) => {
    if (key === 'AC') { setReady(false); setDisplay('0'); setExpression(''); setOperand(null); setOperator(''); setFresh(true); return; }
    if (/^\d$/.test(key)) { setReady(true); setDisplay(fresh || display === 'Error' || display === '0' ? key : display.length < 16 ? display + key : display); setFresh(false); return; }
    if (key === '.') { setReady(true); if (fresh || display === 'Error') setDisplay('0.'); else if (!display.includes('.') && !display.includes('e')) setDisplay(display + '.'); setFresh(false); return; }
    if (key === '⌫') { setReady(true); setDisplay(display === 'Error' || fresh || display.length <= 1 || display.length === 2 && display.startsWith('-') ? '0' : display.slice(0, -1)); setFresh(false); return; }
    if (key === 'π' || key === 'e') { setReady(true); setDisplay(formatResult(key === 'π' ? Math.PI : Math.E)); setFresh(true); return; }
    if (display === 'Error') return;
    const value = Number(display);
    if (['+', '−', '×', '÷', 'xʸ'].includes(key)) {
      setReady(false);
      const next = operand !== null && operator && ready ? calculate(operand, value, operator) : value;
      setDisplay(formatResult(next)); setOperand(Number.isFinite(next) ? next : null); setOperator(Number.isFinite(next) ? key : ''); setExpression(`${formatResult(next)} ${key}`); setFresh(true); return;
    }
    if (key === '=') {
      if (operand === null || !operator || !ready) return;
      record(`${formatResult(operand)} ${operator} ${display}`, calculate(operand, value, operator));
      setReady(false);
      setExpression(`${formatResult(operand)} ${operator} ${display} =`); setDisplay(formatResult(calculate(operand, value, operator))); setOperand(null); setOperator(''); setFresh(true); return;
    }
    record(`${key}(${display})${['sin', 'cos', 'tan'].includes(key) ? degrees ? ' DEG' : ' RAD' : ''}`, scientific(value, key, degrees));
    setExpression(`${key}(${display})`); setDisplay(formatResult(scientific(value, key, degrees))); setFresh(true); setReady(true);
  };

  const keyboard = (event: KeyboardEvent<HTMLDivElement>) => {
    if (event.ctrlKey || event.metaKey || event.altKey) return;
    if (event.key === 'Enter' && (event.target as HTMLElement).tagName === 'BUTTON') return;
    const mapped: Record<string, string> = { '*': '×', '/': '÷', '-': '−', '^': 'xʸ', Enter: '=', Backspace: '⌫', Escape: 'AC' };
    const key = mapped[event.key] || event.key;
    if (keys.includes(key)) { event.preventDefault(); press(key); }
  };

  return <main className="calculator-project"><a href="https://github.com/lu-ci-an/SEN-" className="calculator-back">View project source ↗</a><div className="calculator-project-layout"><section className="calculator-project-story"><p className="calculator-eyebrow">SCIENTIFIC CALCULATOR / WEB REBUILD</p><h1>Small interface.<br />Lots of <em>possibilities.</em></h1><p>A React and TypeScript rebuild inspired by my school calculator project. Explore scientific functions, switch angle modes, and recall recent results without leaving the browser.</p><p>Choose degrees or radians, enter a value, and apply a function. Arithmetic is evaluated in sequence, like a handheld calculator.</p><p className="calculator-keyboard-note">Keyboard: numbers, + − * /, ^ for powers, Enter to calculate, Backspace to delete, and Escape to clear. Select the calculator first.</p></section>
      <div className="working-calculator" role="region" aria-label="Scientific calculator. Keyboard input supported." tabIndex={0} onKeyDown={keyboard}><div className="calculator-display"><button type="button" aria-label={`Angle mode: ${degrees ? 'degrees' : 'radians'}. Click to switch.`} onClick={() => setDegrees(!degrees)}>{degrees ? 'DEG' : 'RAD'} ⇄</button><p>{expression || 'Ready'}</p><output aria-live="polite" aria-atomic="true">{display}</output></div><div className="calculator-keypad">{keys.map(key => <button type="button" key={key} data-key={key} aria-label={({ '⌫': 'Delete last digit', AC: 'Clear all', '√x': 'Square root', 'x²': 'Square', '1/x': 'Reciprocal', 'n!': 'Factorial', 'xʸ': 'Raise to power', '±': 'Change sign', '=': 'Equals' } as Record<string,string>)[key] || key} onClick={() => press(key)}>{key}</button>)}</div><section className="calculator-history" aria-label="Calculation history"><header><h2>Recent calculations</h2><button type="button" disabled={!history.length} onClick={() => setHistory([])}>Clear history</button></header>{history.length ? <ol>{history.map((item, index) => <li key={`${index}-${item.expression}`}><button type="button" aria-label={`Recall ${item.expression} equals ${item.result}`} onClick={() => { setDisplay(item.result); setFresh(true); setReady(true); setExpression(`Recalled: ${item.expression}`); }}><span>{item.expression}</span><strong>{item.result} ↗</strong></button></li>)}</ol> : <p>Your last eight results appear here. Select one to reuse it.</p>}</section></div>
    </div></main>;
}
