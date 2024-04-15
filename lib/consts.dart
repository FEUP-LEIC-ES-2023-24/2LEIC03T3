import 'package:google_maps_flutter/google_maps_flutter.dart';

const String GOOGLE_MAPS_API_KEY = "AIzaSyAN9hOxtxr8IeJeElZK6X0333SMRciHF8s";

const LatLng cascataPortelaHomem = LatLng(41.80389395962604, -8.128425321251514);
const LatLng cascataTahiti = LatLng(41.70374148864667, -8.109515773608667);
const LatLng barragemVilarinhoFurnas = LatLng(41.76368191432093, -8.208996898596055);
const LatLng cascataLaja = LatLng(41.754288013035755, -8.150472273103228);
const LatLng rioCaldo = LatLng(41.67822959800336, -8.184433619517321);
const LatLng rioRabagao = LatLng(41.72148599678184, -7.884560694582003);
const LatLng fonteAzeral = LatLng(41.72957722310375, -8.154035864290401);
const LatLng fonteZanganho = LatLng(41.73076852387701, -8.164587361858167);


List<LatLng> getList()  {
  List<LatLng> coordinatesGeres = [];
  coordinatesGeres.add(cascataPortelaHomem);
  coordinatesGeres.add(cascataTahiti);
  coordinatesGeres.add(barragemVilarinhoFurnas);
  coordinatesGeres.add(cascataLaja);
  coordinatesGeres.add(rioCaldo);
  coordinatesGeres.add(rioRabagao);
  coordinatesGeres.add(fonteAzeral);
  coordinatesGeres.add(fonteZanganho);
  return coordinatesGeres;
}
