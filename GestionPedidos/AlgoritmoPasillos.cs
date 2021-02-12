using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionPedidos
{
    class AlgoritmoPasillos
    {
        SqlConnection conexionAlmacenSql;      

        string consultaSegmentosPedido = "SELECT * FROM segmento S INNER JOIN localizacion_producto LP ON S.id_segmento = LP.id_segmento_loc INNER JOIN producto P ON LP.EAN_loc = P.EAN INNER JOIN linea_pedido LPD ON P.EAN = LPD.EAN_linea_pedido WHERE LPD.id_pedido_linea_pedido = @IdPedido ORDER BY id_pasillo_segmento DESC";

        string consultaSegmentosPedidoTC = "SELECT * FROM segmento S INNER JOIN localizacion_producto LP ON S.id_segmento = LP.id_segmento_loc INNER JOIN producto P ON LP.EAN_loc = P.EAN INNER JOIN linea_pedido LPD ON P.EAN = LPD.EAN_linea_pedido WHERE LPD.id_pedido_linea_pedido = @IdPedido AND id_pasillo_segmento LIKE '%C%' ORDER BY CAST(SUBSTRING(id_pasillo_segmento + '0', PATINDEX('%[0-9]%', id_pasillo_segmento + '0'), LEN(id_pasillo_segmento + '0')) AS INT) ASC";

        string consultaSegmentosPedidoTA = "SELECT * FROM segmento S INNER JOIN localizacion_producto LP ON S.id_segmento = LP.id_segmento_loc INNER JOIN producto P ON LP.EAN_loc = P.EAN INNER JOIN linea_pedido LPD ON P.EAN = LPD.EAN_linea_pedido WHERE LPD.id_pedido_linea_pedido = @IdPedido AND id_pasillo_segmento NOT LIKE '%C%' ORDER BY id_pasillo_segmento + 0 DESC";

        string consultaPasillosTC = "SELECT * FROM pasillo where id_pasillo LIKE '%C%' ORDER BY CAST(SUBSTRING(id_pasillo + '0', PATINDEX('%[0-9]%', id_pasillo + '0'), LEN(id_pasillo + '0')) AS INT) ASC";
        string consultaPasillosTA = "SELECT * FROM pasillo where id_pasillo NOT LIKE '%C%' ORDER BY id_pasillo + 0 ASC";

        public string rutaSinOptimizar(List<Pedido> pedidosAOptimizar)
        {

            List<Segmento> segmentosPedido = new List<Segmento>();
            List<Segmento> segAux = new List<Segmento>();
            string rutasSinOptimizar = "";
            foreach (var pedido in pedidosAOptimizar)
            {
                segAux = segmentosPorPedido(pedido.id_pedido);
                foreach (var segmento in segAux)
                {
                    segmentosPedido.Add(segmento);
                }
            }

            var distinctItems2 = segmentosPedido.GroupBy(x => x.EAN).Select(y => y.First());
            foreach (var segmento in distinctItems2)
            {
                rutasSinOptimizar += segmento.idPasilloSegmento + "-" + segmento.posicionSegmento + "; ";
            }

            return rutasSinOptimizar;
        }

        public string rutaOptimizadaOrdenSegmentos(List<Pedido> pedidosAOptimizar)
        {

            List<Segmento> segmentosPedido = new List<Segmento>();
            List<Segmento> segAuxTC = new List<Segmento>();
            List<Segmento> segAuxTA = new List<Segmento>();
            List<Segmento> segAux = new List<Segmento>();
            string rutaOptimizada = "";

            foreach (var pedido in pedidosAOptimizar)
            {
                segAuxTC.AddRange(segmentosPorPedidoTC(pedido.id_pedido));
                segAuxTA.AddRange(segmentosPorPedidoTA(pedido.id_pedido));
            }

            List<Segmento> STA = segAuxTA.OrderBy(q => int.Parse(q.idPasilloSegmento)).ToList();
            List<Segmento> STC = segAuxTC.OrderBy(q => int.Parse(q.idPasilloSegmento.Substring(1, q.idPasilloSegmento.Length - 1))).ToList();
            segAux.AddRange(STC);
            segAux.AddRange(STA);

            foreach (var segmento in segAux)
            {
                segmentosPedido.Add(segmento);
            }

            var distinctItems2 = segmentosPedido.GroupBy(x => x.EAN).Select(y => y.First());
            foreach (var segmento in distinctItems2)
            {
                rutaOptimizada += segmento.idPasilloSegmento + "-" + segmento.posicionSegmento + "; ";
            }

            return rutaOptimizada;
        }

        private List<Segmento> segmentosPorPedido(int idPedido)
        {
            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);
            conexionAlmacenSql.Open();

            List<Segmento> segmentos = new List<Segmento>();
            SqlCommand sqlSegmentosPedido = new SqlCommand(consultaSegmentosPedido, conexionAlmacenSql);
            sqlSegmentosPedido.Parameters.AddWithValue("@IdPedido", idPedido);
            using (SqlDataReader reader = sqlSegmentosPedido.ExecuteReader())
            {

                while (reader.Read())
                {
                    Segmento segmentoAux = new Segmento();
                    segmentoAux.idPasilloSegmento = reader.GetString(1);
                    segmentoAux.posicionSegmento = reader.GetInt32(3);
                    segmentoAux.EAN = reader.GetInt32(5);
                    segmentos.Add(segmentoAux);
                }

            }
            conexionAlmacenSql.Close();
            return segmentos;
        }

        private List<Segmento> segmentosPorPedidoTC(int idPedido)
        {
            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);
            conexionAlmacenSql.Open();

            List<Segmento> segmentos = new List<Segmento>();
            SqlCommand sqlSegmentosPedido = new SqlCommand(consultaSegmentosPedidoTC, conexionAlmacenSql);
            sqlSegmentosPedido.Parameters.AddWithValue("@IdPedido", idPedido);
            using (SqlDataReader reader = sqlSegmentosPedido.ExecuteReader())
            {

                while (reader.Read())
                {
                    Segmento segmentoAux = new Segmento();
                    segmentoAux.idPasilloSegmento = reader.GetString(1);
                    segmentoAux.posicionSegmento = reader.GetInt32(3);
                    segmentoAux.EAN = reader.GetInt32(5);
                    segmentos.Add(segmentoAux);
                }

            }
            conexionAlmacenSql.Close();
            return segmentos;
        }

        private List<Segmento> segmentosPorPedidoTA(int idPedido)
        {
            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);
            conexionAlmacenSql.Open();

            List<Segmento> segmentos = new List<Segmento>();
            SqlCommand sqlSegmentosPedido = new SqlCommand(consultaSegmentosPedidoTA, conexionAlmacenSql);
            sqlSegmentosPedido.Parameters.AddWithValue("@IdPedido", idPedido);
            using (SqlDataReader reader = sqlSegmentosPedido.ExecuteReader())
            {

                while (reader.Read())
                {
                    Segmento segmentoAux = new Segmento();
                    segmentoAux.idPasilloSegmento = reader.GetString(1);
                    segmentoAux.posicionSegmento = reader.GetInt32(3);
                    segmentoAux.EAN = reader.GetInt32(5);
                    segmentos.Add(segmentoAux);
                }

            }
            conexionAlmacenSql.Close();
            return segmentos;
        }

        public string rutaOptimizadaAlgoritmoOptimo(List<Pedido> pedidosAOptimizar)
        {

            string rutaOptimizada = "";
            List<Segmento> segmentopasillo = new List<Segmento>();
            List<Pasillo> pasillosTC = new List<Pasillo>();
            List<Pasillo> pasillosTCSuperior = new List<Pasillo>();
            List<Pasillo> pasillosTCinferior = new List<Pasillo>();
            List<Pasillo> pasillosTA = new List<Pasillo>();
            List<Pasillo> pasillosTASuperior = new List<Pasillo>();
            List<Pasillo> pasillosTAInferior = new List<Pasillo>();

            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);

            conexionAlmacenSql.Open();
            SqlCommand pasillosTCQuery = new SqlCommand(consultaPasillosTC, conexionAlmacenSql);
            using (SqlDataReader reader = pasillosTCQuery.ExecuteReader())
            {
                while (reader.Read())
                {
                    Pasillo pasilloAux = new Pasillo();
                    pasilloAux.idPasillo = reader.GetString(0);
                    pasilloAux.idAreaPasillo = reader.GetString(1);
                    pasilloAux.longitud = reader.GetInt32(2);
                    pasilloAux.anchura = reader.GetInt32(3);
                    pasillosTC.Add(pasilloAux);
                }

                List<List<Pasillo>> pasillosTCAux = dividirPasillo(pasillosTC);
                pasillosTCinferior = pasillosTCAux[0];
                pasillosTCSuperior = pasillosTCAux[1];

            }
            conexionAlmacenSql.Close();

            conexionAlmacenSql.Open();
            SqlCommand pasillosTAQuery = new SqlCommand(consultaPasillosTA, conexionAlmacenSql);
            using (SqlDataReader reader = pasillosTAQuery.ExecuteReader())
            {

                while (reader.Read())
                {
                    Pasillo pasilloAux = new Pasillo();
                    pasilloAux.idPasillo = reader.GetString(0);
                    pasilloAux.idAreaPasillo = reader.GetString(1);
                    pasilloAux.longitud = reader.GetInt32(2);
                    pasilloAux.anchura = reader.GetInt32(3);
                    pasillosTA.Add(pasilloAux);
                }

                List<List<Pasillo>> pasillosTAAux = dividirPasillo(pasillosTA);
                pasillosTASuperior = pasillosTAAux[0];
                pasillosTAInferior = pasillosTAAux[1];
            }

            conexionAlmacenSql.Close();

            return rutaOptimizada;

        }


        public int distanciaSegmentos (Segmento segmentoOrigen, Segmento segmentoDestino)
        {
            
            int largoSegmento = 1;
            int anchoPasillo = 3;
            int result = (segmentoOrigen.posicionSegmento - segmentoDestino.posicionSegmento)* largoSegmento + (int.Parse(segmentoOrigen.idPasilloSegmento.Replace("C", "")) - int.Parse(segmentoDestino.idPasilloSegmento.Replace("C", ""))) * anchoPasillo;
            return result;
        }
        public static List<List<Pasillo>> dividirPasillo(List<Pasillo> source)
        {
            return source
                .Select((x, i) => new { Index = i, Value = x })
                .GroupBy(x => x.Index / (source.Count()/2))
                .Select(x => x.Select(v => v.Value).ToList())
                .ToList();
        }
    }
}