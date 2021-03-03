# rutasAlmacenes
Apliación para la gestión de recogida de pedidos en almacenes multitienda.

Entre los ficheros disponibles se encuentra la memoria del TFG que dio origen a este desarrollo.

Se incluye un export de la BBDD para facilitar las pruebas.

Para trabajar con el proyecto, se recomienda uar el software Visual Studio Community. Primero abrimos la solución GestionPedidos.sln y posteriormente agregamos el proyecto existente CromulentBisgetti.ContainerPacking.csproj. Con estos módulos tenemos todas las funcionalidades descritas en el proyecto funcionando.

Una vez tenemos las soluciones generadas, necesitamos adaptar la BBDD. Un Script con las tablas y la información de la BBDD se puede encontrar en la raíz de este proyecto. En los ficheros de configuración del proyecto se encuentra toda la información relativa ala configuración de la BBDD y su conectividad con la solución principal. No obstante, si se desea personalizar los parámetros de configuración de la BBDD hay que tenerlo en cuenta para modificar las cadenas de conexión en GestionPedidos.Properties.Settings.almacenConnectionString.

La parte de algoritmia extraída de la web www.roodbergen.com/warehouse/frames.htm?demo no ha sido incluida debido a que no se encuentra la licencia de uso en la web citada. No obstante  se detalla como el usuario puede incluirla de manera sencilla para completar todas las funcionalidades mencionadas en la memoria.
El software que encontramos en dicha página esta programado en javascript (versión 1.2 -- https://developer.mozilla.org/es/docs/Web/JavaScript/Novedades_en_JavaScript/1.2  -- según el propio autor). Para ejecutar código .js en un programa basado en WPF necesitamos crear un documento HTML. En dicho documento inyectaremos el siguiente código html:
<html>
<head>
<title>Interactive Warehouse</title>
<SCRIPT LANGUAGE="JavaScript1.2">
<!--
b=2;g=4;l=5;d=1;a='5';c='2';
tweedekeer='nee';
aantalgeladen=0;
achtergrond1='99ccff';achtergrond2='cceeff';achtergrond3='66aaff';tekst='000000';
scherm=1;

function starten(nummer){
aantalgeladen++
if(nummer==1){
top.frames[3].location="mag_view.htm"
}
if(aantalgeladen==12){
  top.frames[0].document.bgColor=top.achtergrond1;
  top.frames[0].document.formulier.dialoog.value="Let the Wizard help you to discover this site.";
  top.frames[3].scherm(1)
}}

// -->
</SCRIPT>
</head>

<SCRIPT LANGUAGE="JavaScript1.2">
<!--
if (navigator.userAgent.indexOf('Win16') != -1) {
document.write("<FRAMESET ROWS='50,*' border=0>");
document.write("<FRAME SRC='leeg.htm' name='Boven' scrolling='no'>");
document.write("<FRAMESET COLS='200,*' border=0>");
document.write("<FRAMESET ROWS='100%,*' border=0>");
document.write("<FRAME SRC='leeg.htm' name='Links' scrolling='auto'>");
document.write("<FRAME SRC='leeg.htm' name='Linksonder' scrolling='no'>");
document.write("</FRAMESET>");
document.write("<FRAME SRC='win31.htm' name='Rechts' scrolling='auto'>");
document.write("</FRAMESET>");
document.write("</FRAMESET>");
}
else{
document.write("<FRAMESET ROWS='50,*' border=0>");
document.write("<FRAME SRC='balk.htm' name='Boven' scrolling='no'>");
document.write("<FRAMESET COLS='200,*' border=0>");
document.write("<FRAMESET ROWS='100%,*' border=0>");
document.write("<FRAME SRC='links.htm' name='Links' scrolling='auto'>");
document.write("<FRAME SRC='programs.htm' name='Linksonder' scrolling='no'>");
document.write("</FRAMESET>");
document.write("<FRAME SRC='leeg.htm' name='Rechts' scrolling='no'>");
document.write("</FRAMESET>");
document.write("</FRAMESET>");
}
// --></SCRIPT>

</html>

Posteriormente inyectaremos todos los fiicheros htm como ficheros htm. Recomiendo inyectar sólo la aprte incluidas entre etiquetas <script>. EN el fichero invul.htm se modifica la función:
  
function RandomOrder(){
  aantal=eval(fgrootte+'value');
  controleerGrootte();
  if(InputGrootte=='goed'){
    NieuweOrder();
    pos=1;
    for(i=1;i<=aantal;i++){
      legelocatie=false;
      while(!legelocatie){
        blok=2*Math.ceil(eval(top.b)*Math.random());
        gang=Math.ceil(eval(top.g)*Math.random());
        loc=Math.ceil(eval(top.l)*Math.random());
        if(pos==1){pos=3}
        else{pos=1}
        if(top.frames[3].L[blok][gang][pos][loc]!=0){
          legelocatie=false
        }
        else{
          legelocatie=true
        }
      }
      top.frames[3].selecteer(blok,gang,pos,loc)
    }
  }
}

Para que rellene las posiciones con items en pedidos.
Por último en optimal.htm se genera las rutas óptimas. Estas se presentan en arrays que deben ser editados en la función:

function getshortestclass(){
shortestclass=2;
if(l[3]<l[shortestclass]){shortestclass=3}
if(l[4]<l[shortestclass]){shortestclass=4}
if(l[5]<l[shortestclass]){shortestclass=5}
if(l[6]<l[shortestclass]){shortestclass=6}
if(l[7]<l[shortestclass]){shortestclass=7}
if(l[8]<l[shortestclass]){shortestclass=8}
}


