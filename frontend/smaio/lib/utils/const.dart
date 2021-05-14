import 'package:flutter/material.dart';
import 'package:smaio/models/model.ano.dart';
import 'package:smaio/models/model.grupo.dart';
import 'package:intl/intl.dart';

Color menuCadastroLateral = Colors.grey[200]!;
Color fundoBranco = Colors.grey[50]!;

String hostapi = '147.135.87.217';
String localhost = 'localhost';
String tituloSistema = 'SMAIO - FERRO VELHO VIRTUAL';

TextStyle styleTexto() {
  return TextStyle(
    color: Colors.green[900],
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

var formatFloat = new NumberFormat.currency(
  decimalDigits: 2,
  locale: 'pt',
  symbol: '',
);

List<Grupo> dicGrupo = [
  Grupo(gruId: 1, gruDescricao: "Ar & Combustível"),
  Grupo(gruId: 2, gruDescricao: "Eixos e Freios"),
  Grupo(gruId: 3, gruDescricao: "Lataria"),
  Grupo(gruId: 4, gruDescricao: "Elétrica"),
  Grupo(gruId: 5, gruDescricao: "Motor"),
  Grupo(gruId: 6, gruDescricao: "Vidros"),
  Grupo(gruId: 7, gruDescricao: "Ar condicionado"),
  Grupo(gruId: 8, gruDescricao: "Interior"),
  Grupo(gruId: 9, gruDescricao: "Lampadas"),
  Grupo(gruId: 10, gruDescricao: "Direção e Suspensão"),
  Grupo(gruId: 11, gruDescricao: "Transmissão"),
];

List<Ano> dicAno = [
  Ano(anoId: 1, anoDescricao: "1970"),
  Ano(anoId: 2, anoDescricao: "1971"),
  Ano(anoId: 3, anoDescricao: "1972"),
  Ano(anoId: 4, anoDescricao: "1973"),
  Ano(anoId: 5, anoDescricao: "1974"),
  Ano(anoId: 6, anoDescricao: "1975"),
  Ano(anoId: 7, anoDescricao: "1976"),
  Ano(anoId: 8, anoDescricao: "1977"),
  Ano(anoId: 9, anoDescricao: "1978"),
  Ano(anoId: 10, anoDescricao: "1979"),
  Ano(anoId: 11, anoDescricao: "1980"),
  Ano(anoId: 12, anoDescricao: "1981"),
  Ano(anoId: 13, anoDescricao: "1982"),
  Ano(anoId: 14, anoDescricao: "1983"),
  Ano(anoId: 15, anoDescricao: "1984"),
  Ano(anoId: 16, anoDescricao: "1985"),
  Ano(anoId: 17, anoDescricao: "1986"),
  Ano(anoId: 18, anoDescricao: "1987"),
  Ano(anoId: 19, anoDescricao: "1988"),
  Ano(anoId: 20, anoDescricao: "1989"),
  Ano(anoId: 21, anoDescricao: "1990"),
  Ano(anoId: 22, anoDescricao: "1991"),
  Ano(anoId: 23, anoDescricao: "1992"),
  Ano(anoId: 24, anoDescricao: "1993"),
  Ano(anoId: 25, anoDescricao: "1994"),
  Ano(anoId: 26, anoDescricao: "1995"),
  Ano(anoId: 27, anoDescricao: "1996"),
  Ano(anoId: 28, anoDescricao: "1997"),
  Ano(anoId: 29, anoDescricao: "1998"),
  Ano(anoId: 30, anoDescricao: "1999"),
  Ano(anoId: 31, anoDescricao: "2000"),
  Ano(anoId: 32, anoDescricao: "2001"),
  Ano(anoId: 33, anoDescricao: "2002"),
  Ano(anoId: 34, anoDescricao: "2003"),
  Ano(anoId: 35, anoDescricao: "2004"),
  Ano(anoId: 36, anoDescricao: "2005"),
  Ano(anoId: 37, anoDescricao: "2006"),
  Ano(anoId: 38, anoDescricao: "2007"),
  Ano(anoId: 39, anoDescricao: "2008"),
  Ano(anoId: 40, anoDescricao: "2009"),
  Ano(anoId: 41, anoDescricao: "2010"),
  Ano(anoId: 42, anoDescricao: "2011"),
  Ano(anoId: 43, anoDescricao: "2012"),
  Ano(anoId: 44, anoDescricao: "2013"),
  Ano(anoId: 45, anoDescricao: "2014"),
  Ano(anoId: 46, anoDescricao: "2015"),
  Ano(anoId: 47, anoDescricao: "2016"),
  Ano(anoId: 48, anoDescricao: "2017"),
  Ano(anoId: 49, anoDescricao: "2018"),
  Ano(anoId: 50, anoDescricao: "2019"),
  Ano(anoId: 51, anoDescricao: "2020"),
  Ano(anoId: 52, anoDescricao: "2021"),
  Ano(anoId: 53, anoDescricao: "2022"),
  Ano(anoId: 54, anoDescricao: "2023"),
  Ano(anoId: 55, anoDescricao: "2024"),
  Ano(anoId: 56, anoDescricao: "2025"),
  Ano(anoId: 57, anoDescricao: "2026"),
  Ano(anoId: 58, anoDescricao: "2027"),
  Ano(anoId: 59, anoDescricao: "2028"),
  Ano(anoId: 60, anoDescricao: "2029"),
  Ano(anoId: 61, anoDescricao: "2030"),
  Ano(anoId: 62, anoDescricao: "2031"),
  Ano(anoId: 63, anoDescricao: "2032"),
  Ano(anoId: 64, anoDescricao: "2033"),
  Ano(anoId: 65, anoDescricao: "2034"),
  Ano(anoId: 66, anoDescricao: "2035"),
  Ano(anoId: 67, anoDescricao: "2036"),
  Ano(anoId: 68, anoDescricao: "2037"),
  Ano(anoId: 69, anoDescricao: "2038"),
  Ano(anoId: 70, anoDescricao: "2039"),
  Ano(anoId: 71, anoDescricao: "2040"),
  Ano(anoId: 72, anoDescricao: "2041"),
  Ano(anoId: 73, anoDescricao: "2042"),
  Ano(anoId: 74, anoDescricao: "2043"),
  Ano(anoId: 75, anoDescricao: "2044"),
];
