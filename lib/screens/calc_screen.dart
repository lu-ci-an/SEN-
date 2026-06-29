import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/technotifier.dart';

class TechCalcScreen extends ConsumerStatefulWidget {
  const TechCalcScreen({super.key});
  @override ConsumerState<TechCalcScreen> createState() => _TechCalcScreenState();
}
class _TechCalcScreenState extends ConsumerState<TechCalcScreen> {
  bool _deg = true;

  static const _kBg=Color(0xFF001210);static const _kSci=Color(0xFF004D40);static const _kSciTx=Color(0xFF26A69A);
  static const _kNum=Color(0xFF001514);static const _kOp=Color(0xFF00695C);static const _kOpTx=Color(0xFF26A69A);
  static const _kFn=Color(0xFF001514);static const _kEq=Color(0xFF004D40);static const _kAc=Color(0xFFB71C1C);
  Widget _key(String lbl, VoidCallback fn, {Color bg=_kNum,Color fg=Colors.white,int flex=1,double fs=15.5}) {
    return Expanded(flex:flex,child:Padding(padding:const EdgeInsets.all(1.6),child:Material(color:bg,borderRadius:BorderRadius.circular(4),child:InkWell(borderRadius:BorderRadius.circular(4),splashColor:Colors.white12,onTap:fn,child:Container(alignment:Alignment.center,child:Text(lbl,style:TextStyle(color:fg,fontSize:fs,fontWeight:FontWeight.w500,letterSpacing:-0.2)))))));
  }
  Widget _row(List<Widget> k)=>Expanded(child:Row(crossAxisAlignment:CrossAxisAlignment.stretch,children:k));
  Widget _chip(String t)=>Container(padding:const EdgeInsets.symmetric(horizontal:5,vertical:1),decoration:BoxDecoration(color:const Color(0xFF6A8C45).withValues(alpha:0.35),borderRadius:BorderRadius.circular(3)),child:Text(t,style:const TextStyle(color:Color(0xFF4A6228),fontSize:10,fontWeight:FontWeight.bold)));
  Widget _scaffold(String d,String e,bool deg,VoidCallback tg){
    return Scaffold(backgroundColor:_kBg,body:SafeArea(child:Column(children:[
      Container(width:double.infinity,color:const Color(0xFFCDD8A8),padding:const EdgeInsets.fromLTRB(14,10,14,12),child:Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
        Row(children:[_chip(deg?'DEG':'RAD'),const Spacer(),GestureDetector(onTap:tg,child:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:3),decoration:BoxDecoration(color:const Color(0xFF8CA870),borderRadius:BorderRadius.circular(4)),child:Text(deg?'→ RAD':'→ DEG',style:const TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.bold))))]),
        const SizedBox(height:6),
        Text(e.isEmpty?' ':e,style:const TextStyle(color:Color(0xFF4A6228),fontSize:13),textAlign:TextAlign.right,maxLines:1,overflow:TextOverflow.ellipsis),
        const SizedBox(height:2),
        Text(d,style:TextStyle(color:const Color(0xFF1A2A08),fontSize:44.0,fontWeight:FontWeight.w100,letterSpacing:-1.5),textAlign:TextAlign.right,maxLines:1,overflow:TextOverflow.ellipsis),
      ])),
      Expanded(child:Padding(padding:const EdgeInsets.all(3),child:Column(children:[
        _row([_key('sin', () => ref.read(techproviderProv.notifier).sci('sin'), bg:_kSci, fg:_kSciTx), _key('cos', () => ref.read(techproviderProv.notifier).sci('cos'), bg:_kSci, fg:_kSciTx), _key('tan', () => ref.read(techproviderProv.notifier).sci('tan'), bg:_kSci, fg:_kSciTx), _key('log', () => ref.read(techproviderProv.notifier).sci('log'), bg:_kSci, fg:_kSciTx), _key('ln', () => ref.read(techproviderProv.notifier).sci('ln'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('asin', () => ref.read(techproviderProv.notifier).sci('asin'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('acos', () => ref.read(techproviderProv.notifier).sci('acos'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('atan', () => ref.read(techproviderProv.notifier).sci('atan'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('√x', () => ref.read(techproviderProv.notifier).sci('sqrt'), bg:_kSci, fg:_kSciTx), _key('x²', () => ref.read(techproviderProv.notifier).sci('x²'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('sinh', () => ref.read(techproviderProv.notifier).sci('sinh'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('cosh', () => ref.read(techproviderProv.notifier).sci('cosh'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('tanh', () => ref.read(techproviderProv.notifier).sci('tanh'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('x³', () => ref.read(techproviderProv.notifier).sci('x³'), bg:_kSci, fg:_kSciTx), _key('1/x', () => ref.read(techproviderProv.notifier).sci('1/x'), bg:_kSci, fg:_kSciTx)]),
        _row([_key('n!', () => ref.read(techproviderProv.notifier).sci('n!'), bg:_kSci, fg:_kSciTx), _key('nPr', () => ref.read(techproviderProv.notifier).combo('nPr'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('nCr', () => ref.read(techproviderProv.notifier).combo('nCr'), bg:_kSci, fg:_kSciTx, fs:13.5), _key('π', () => ref.read(techproviderProv.notifier).sci('π'), bg:_kSci, fg:const Color(0xFFFFD54F)), _key('e', () => ref.read(techproviderProv.notifier).sci('e'), bg:_kSci, fg:const Color(0xFFFFD54F))]),
        _row([_key('AC',() => ref.read(techproviderProv.notifier).clear(),bg:_kAc,fg:Colors.white),_key('⌫',() => ref.read(techproviderProv.notifier).back(),bg:const Color(0xFF3A1818),fg:const Color(0xFFFF8A80)),_key('%',() => ref.read(techproviderProv.notifier).pct(),bg:_kFn,fg:Colors.white70),_key('|x|',() => ref.read(techproviderProv.notifier).sci('|x|'),bg:_kFn,fg:Colors.white60),_key('+/−',() => ref.read(techproviderProv.notifier).sign(),bg:_kFn,fg:Colors.white70)]),
        _row([_key('7',() => ref.read(techproviderProv.notifier).digit('7'),fs:20),_key('8',() => ref.read(techproviderProv.notifier).digit('8'),fs:20),_key('9',() => ref.read(techproviderProv.notifier).digit('9'),fs:20),_key('÷',() => ref.read(techproviderProv.notifier).oper('÷'),bg:_kOp,fg:_kOpTx,fs:18),_key('×',() => ref.read(techproviderProv.notifier).oper('×'),bg:_kOp,fg:_kOpTx,fs:18)]),
        _row([_key('4',() => ref.read(techproviderProv.notifier).digit('4'),fs:20),_key('5',() => ref.read(techproviderProv.notifier).digit('5'),fs:20),_key('6',() => ref.read(techproviderProv.notifier).digit('6'),fs:20),_key('−',() => ref.read(techproviderProv.notifier).oper('−'),bg:_kOp,fg:_kOpTx,fs:18),_key('(',(){}  ,bg:_kFn,fg:Colors.white54)]),
        _row([_key('1',() => ref.read(techproviderProv.notifier).digit('1'),fs:20),_key('2',() => ref.read(techproviderProv.notifier).digit('2'),fs:20),_key('3',() => ref.read(techproviderProv.notifier).digit('3'),fs:20),_key('+',() => ref.read(techproviderProv.notifier).oper('+'),bg:_kOp,fg:_kOpTx,fs:18),_key(')',(){}  ,bg:_kFn,fg:Colors.white54)]),
        _row([_key('0',() => ref.read(techproviderProv.notifier).digit('0'),flex:2,fs:20),_key('.',() => ref.read(techproviderProv.notifier).dot(),fs:20),_key('EXP',(){}  ,bg:_kFn,fg:Colors.white54,fs:12),_key('=',() => ref.read(techproviderProv.notifier).equals(),bg:_kEq,fg:Colors.white,fs:22)]),
      ]))),
    ])));
  }

  @override
  Widget build(BuildContext context) {
    final st = ref.watch(techproviderProv);
    return _scaffold(st.display, st.expression, _deg, () => setState(() => _deg = !_deg));
  }
}
