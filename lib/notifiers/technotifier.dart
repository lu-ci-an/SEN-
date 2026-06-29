
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class CalcStateModel {
  final String display;
  final String expression;
  const CalcStateModel({this.display = '0', this.expression = ''});
  CalcStateModel copyWith({String? display, String? expression}) =>
      CalcStateModel(display: display ?? this.display, expression: expression ?? this.expression);
}

class TechNotifier extends StateNotifier<CalcStateModel> {
  TechNotifier() : super(const CalcStateModel());

  double _operand = 0;
  String _op = '';
  bool _fresh = false;

  void digit(String d) {
    if (_fresh) { state = state.copyWith(display: d); _fresh = false; }
    else { state = state.copyWith(display: state.display == '0' ? d : state.display + d); }
  }

  void dot() {
    if (_fresh) { state = state.copyWith(display: '0.'); _fresh = false; return; }
    if (!state.display.contains('.')) state = state.copyWith(display: state.display + '.');
  }

  void oper(String op) {
    _operand = double.tryParse(state.display) ?? 0;
    _op = op;
    state = state.copyWith(expression: '${state.display} $op');
    _fresh = true;
  }

  void equals() {
    if (_op.isEmpty) return;
    final b = double.tryParse(state.display) ?? 0;
    late double r;
    switch (_op) {
      case '+': r = _operand + b; break;
      case '−': r = _operand - b; break;
      case '×': r = _operand * b; break;
      case '÷': r = b != 0 ? _operand / b : double.nan; break;
      default:  r = b;
    }
    state = state.copyWith(
      expression: '${state.expression} ${state.display} =',
      display: _fmt(r),
    );
    _op = ''; _fresh = true;
  }

  void clear() { state = const CalcStateModel(); _operand=0; _op=''; _fresh=false; }

  void sign() {
    if (state.display=='0'||state.display=='Error') return;
    final d = state.display.startsWith('-') ? state.display.substring(1) : '-${state.display}';
    state = state.copyWith(display: d);
  }

  void pct() {
    final v = double.tryParse(state.display) ?? 0;
    state = state.copyWith(display: _fmt(v/100));
  }

  void back() {
    if (state.display=='Error') { state=state.copyWith(display:'0'); return; }
    if (state.display.length<=1) { state=state.copyWith(display:'0'); return; }
    var d = state.display.substring(0, state.display.length-1);
    if (d=='-') d='0';
    state = state.copyWith(display: d);
  }

  void sci(String fn) {
    final x = double.tryParse(state.display) ?? 0;
    late double r;
    switch (fn) {
      case 'sin':  r = _sinD(x); break;
      case 'cos':  r = _cosD(x); break;
      case 'tan':  r = _tanD(x); break;
      case 'asin': r = _asinD(x); break;
      case 'acos': r = _acosD(x); break;
      case 'atan': r = _atanD(x); break;
      case 'sinh': r = (_ex(x)-_ex(-x))/2; break;
      case 'cosh': r = (_ex(x)+_ex(-x))/2; break;
      case 'tanh':
        final s=(_ex(x)-_ex(-x))/2; final c=(_ex(x)+_ex(-x))/2;
        r = c!=0?s/c:double.nan; break;
      case 'log':  r = x>0 ? math.log(x)/math.ln10 : double.nan; break;
      case 'ln':   r = x>0 ? math.log(x) : double.nan; break;
      case 'sqrt': r = x>=0 ? math.sqrt(x) : double.nan; break;
      case 'x²': r = x*x; break;
      case 'x³': r = x*x*x; break;
      case '1/x':  r = x!=0 ? 1/x : double.nan; break;
      case '|x|':  r = x.abs(); break;
      case 'n!':
        if (x<0||x!=x.floorToDouble()){state=state.copyWith(display:'Error');return;}
        r = _fact(x.toInt()).toDouble(); break;
      case 'π': state=state.copyWith(display:math.pi.toString()); _fresh=true; return;
      case 'e':   state=state.copyWith(display:math.e.toString()); _fresh=true; return;
      default: return;
    }
    state=state.copyWith(display:_fmt(r)); _fresh=true;
  }

  void combo(String type) {
    if (_op=='nPr'||_op=='nCr') {
      final r = double.tryParse(state.display)??0;
      final ni=_operand.toInt(); final ri=r.toInt();
      if (_operand<0||r<0||r>_operand){state=state.copyWith(display:'Error');_op='';return;}
      final nFact=_fact(ni).toDouble(); final nrFact=_fact(ni-ri).toDouble();
      state=state.copyWith(
        display: type=='nPr' ? _fmt(nFact/nrFact) : _fmt(nFact/(nrFact*_fact(ri))));
      _op=''; _fresh=true;
    } else {
      _operand=double.tryParse(state.display)??0;
      _op=type; state=state.copyWith(expression:'${state.display} $type'); _fresh=true;
    }
  }

  double _sinD(double d) => math.sin(d*math.pi/180);
  double _cosD(double d) => math.cos(d*math.pi/180);
  double _tanD(double d) => math.tan(d*math.pi/180);
  double _asinD(double d) => math.asin(d)*180/math.pi;
  double _acosD(double d) => math.acos(d)*180/math.pi;
  double _atanD(double d) => math.atan(d)*180/math.pi;
  double _ex(double x) => math.exp(x);
  int _fact(int n) => n<=1?1:n*_fact(n-1);

  String _fmt(double r) {
    if (r.isNaN||r.isInfinite) return 'Error';
    if (r==r.truncateToDouble()&&r.abs()<1e15) return r.toInt().toString();
    return r.toStringAsFixed(10).replaceAll(RegExp(r'0+$'),'').replaceAll(RegExp(r'\.$'),'');
  }
}

final techproviderProv = StateNotifierProvider<TechNotifier, CalcStateModel>(
  (ref) => TechNotifier(),
);
