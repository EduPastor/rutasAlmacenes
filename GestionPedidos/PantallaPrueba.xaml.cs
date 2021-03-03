using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace GestionPedidos
{
    /// <summary>
    /// Lógica de interacción para PantallaPrueba.xaml
    /// </summary>
    public partial class PantallaPrueba : Window
    {
        SqlConnection conexionAlmacenSql;
        //string consultaClientesQuery = "SELECT * FROM cliente";
        string consultaPasillosQuery = "SELECT * FROM pasillo";
        string consultaPedidosQuery = "SELECT * FROM pedido";
        string consultaFechasQuery = "SELECT DISTINCT fecha FROM pedido";
        string consultaSegmentosPasilloQuery = "SELECT * FROM segmento S INNER JOIN pasillo P ON P.id_pasillo = S.id_pasillo_segmento WHERE P.id_pasillo=@PasilloId";
        string consultaPedidosFechaQuery = "SELECT CONCAT(id_pedido,' - ',dni_cliente,' - ',fecha) AS PEDIDOSCOMPLETOS FROM pedido WHERE fecha = @Fecha";
        string consultaNumPedidosFechaQuery = "SELECT COUNT (id_pedido) FROM pedido WHERE fecha = '2021-01-03'";
        string consultaPedidosIdQuery = "SELECT * FROM linea_pedido LP INNER JOIN pedido P ON P.id_pedido = LP.id_pedido_linea_pedido WHERE P.id_pedido=@PedidoId";
        //string consultaPedidosFechaPruebaQuery = "SELECT CONCAT(id_pedido,' - ',dni_cliente,' - ',fecha) AS PEDIDOSCOMPLETOS FROM pedido WHERE fecha ='2021-01-03'";
        string consultaPedidosFechaPruebaQuery = "SELECT (id_pedido) FROM pedido WHERE fecha ='2021-01-03'";
        string consultaPedidosFechaPruebaQuery2 = "SELECT CONCAT (EAN, ' - ', categoria_producto, ' - ', nombre, ' - ', EAN_linea_pedido, ' - ', id_pedido_linea_pedido, ' - ', cantidad ) AS PEDIDOSCOMPLETOS FROM producto A inner join linea_pedido LP ON A.EAN = LP.EAN_linea_pedido WHERE LP.id_pedido_linea_pedido = @PedidoId";
        string consultaTotalElementosPedido = "SELECT SUM(cantidad) FROM producto P inner join linea_pedido LP ON P.EAN = LP.EAN_linea_pedido WHERE LP.id_pedido_linea_pedido = @PedidoId";
        public PantallaPrueba()
        {
            InitializeComponent();

            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);

            //consultaClientesPorLocalidad(16004);
            //consultaClientes();
            consultFechas();
            consultaPasillos();
            consultaPedidos();
            consultaPedidosPrueba();
        }
        /*private void consultaClientesPorLocalidad(int codigoPostal)
        {
            string consultaClientesLocalidad = "SELECT * FROM cliente WHERE cp= '" + codigoPostal +"'";

            SqlDataAdapter adpatadorClientesLocalidad = new SqlDataAdapter(consultaClientesLocalidad, conexionAlmacenSql);

            using (adpatadorClientesLocalidad)
            {
                DataTable tablaClientesLocalidad = new DataTable();

                adpatadorClientesLocalidad.Fill(tablaClientesLocalidad);

                listaClientes.DisplayMemberPath = "Nombre";
                //campo clave
                listaClientes.SelectedValuePath = "DNI";
                listaClientes.ItemsSource = tablaClientesLocalidad.DefaultView;
            }
        }

        private void consultaClientes()
        {
            
            SqlDataAdapter adpatadorClientes = new SqlDataAdapter(consultaClientesQuery, conexionAlmacenSql);

            using (adpatadorClientes)
            {
                DataTable tablaClientesLocalidad = new DataTable();

                adpatadorClientes.Fill(tablaClientesLocalidad);

                listaClientes.DisplayMemberPath = "Nombre";
                //campo clave
                listaClientes.SelectedValuePath = "DNI";
                listaClientes.ItemsSource = tablaClientesLocalidad.DefaultView;
            }
        }*/

        private void consultFechas()
        {

            SqlDataAdapter adpatadorFechas = new SqlDataAdapter(consultaFechasQuery, conexionAlmacenSql);

            using (adpatadorFechas)
            {
                DataTable tablafechas = new DataTable();

                adpatadorFechas.Fill(tablafechas);

                listaFechas.DisplayMemberPath = "fecha";
                //campo clave
                listaFechas.SelectedValuePath = "fecha";
                listaFechas.ItemsSource = tablafechas.DefaultView;
            }
        }

        private void consultaPedidos()
        {

            SqlDataAdapter adpatadorPedidos = new SqlDataAdapter(consultaPedidosQuery, conexionAlmacenSql);

            using (adpatadorPedidos)
            {
                DataTable tablapedidos = new DataTable();

                adpatadorPedidos.Fill(tablapedidos);

                listaPedidos.DisplayMemberPath = "id_pedido";
                //campo clave
                listaPedidos.SelectedValuePath = "id_pedido";
                listaPedidos.ItemsSource = tablapedidos.DefaultView;
            }
        }

        private void consultaPasillos()
        {

            SqlDataAdapter adpatadorPasillos = new SqlDataAdapter(consultaPasillosQuery, conexionAlmacenSql);

            using (adpatadorPasillos)
            {
                DataTable tablapasillos = new DataTable();

                adpatadorPasillos.Fill(tablapasillos);

                listaPasillos.DisplayMemberPath = "id_pasillo";
                listaPasillos.SelectedValuePath = "id_pasillo";
                listaPasillos.ItemsSource = tablapasillos.DefaultView;
            }
        }

        private void consultaSegmentosPorPasillo()
        {

            SqlCommand sqlSegmentosPasillo = new SqlCommand(consultaSegmentosPasilloQuery, conexionAlmacenSql);

            SqlDataAdapter adpatadorSegmentosPorPasillo = new SqlDataAdapter(sqlSegmentosPasillo);

            using (adpatadorSegmentosPorPasillo)
            {
                sqlSegmentosPasillo.Parameters.AddWithValue("@PasilloId", listaPasillos.SelectedValue);

                DataTable tablaSegmentosPasillo = new DataTable();

                adpatadorSegmentosPorPasillo.Fill(tablaSegmentosPasillo);

                listaSegmentos.DisplayMemberPath = "id_segmento";
                listaSegmentos.SelectedValuePath = "id_segmento";
                listaSegmentos.ItemsSource = tablaSegmentosPasillo.DefaultView;
            }
        }

        private void consultaPedidosFecha()
        {

            SqlCommand sqlPedidosFecha = new SqlCommand(consultaPedidosFechaQuery, conexionAlmacenSql);

            SqlDataAdapter adpatadorPedidosFecha = new SqlDataAdapter(sqlPedidosFecha);

            using (adpatadorPedidosFecha)
            {
                sqlPedidosFecha.Parameters.AddWithValue("@Fecha", listaFechas.SelectedValue);

                DataTable tablaPedidosFecha = new DataTable();

                adpatadorPedidosFecha.Fill(tablaPedidosFecha);

                listaPedidosFecha.DisplayMemberPath = "PEDIDOSCOMPLETOS";
                listaPedidosFecha.SelectedValuePath = "id_pedido";
                listaPedidosFecha.ItemsSource = tablaPedidosFecha.DefaultView;
            }
        }

        private void consultaPedidosPrueba()
        {

            SqlDataAdapter adpatadorPedidosFechaPrueba = new SqlDataAdapter(consultaPedidosFechaPruebaQuery, conexionAlmacenSql);

            using (adpatadorPedidosFechaPrueba)
            {
                DataTable tablaPedidosFechaPrueba = new DataTable();

                adpatadorPedidosFechaPrueba.Fill(tablaPedidosFechaPrueba);

                listaPedidos0301.DisplayMemberPath = "id_pedido";
                listaPedidos0301.SelectedValuePath = "id_pedido";
                listaPedidos0301.ItemsSource = tablaPedidosFechaPrueba.DefaultView;
            }

        }

        private void consultaPedidosFechaPrueba()
        {

            SqlCommand sqlPedidosFecha = new SqlCommand(consultaPedidosFechaPruebaQuery2, conexionAlmacenSql);

            SqlDataAdapter adpatadorPedidosFecha = new SqlDataAdapter(sqlPedidosFecha);

            using (adpatadorPedidosFecha)
            {
                sqlPedidosFecha.Parameters.AddWithValue("@PedidoId", listaPedidos0301.SelectedValue);

                DataTable tablaPedidosFecha = new DataTable();

                adpatadorPedidosFecha.Fill(tablaPedidosFecha);

                listaProductosPedidos0301.DisplayMemberPath = "PEDIDOSCOMPLETOS";
                listaProductosPedidos0301.SelectedValuePath = "id_pedido";
                listaProductosPedidos0301.ItemsSource = tablaPedidosFecha.DefaultView;
            }

            int numProductosPedido = 0;
            conexionAlmacenSql.Open();
            SqlCommand consultaPedidosPrueba = new SqlCommand(consultaTotalElementosPedido, conexionAlmacenSql);
            consultaPedidosPrueba.Parameters.AddWithValue("@PedidoId", listaPedidos0301.SelectedValue);
            using (SqlDataReader reader = consultaPedidosPrueba.ExecuteReader())
            {

                if (reader.Read())
                {
                    numProductosPedido = numProductosPedido + reader.GetInt32(0);
                }
            }
            conexionAlmacenSql.Close();
            labelProductosPedido.Content = numProductosPedido;
            labelProductosPedido.Content = numProductosPedido;

            labelCajas.Content = numProductosPedido / 20 + 1;
            labelCarros.Content = (numProductosPedido / 20 + 1) / 12 + 1;
        }

        private void consultaPedidosId()
        {

            SqlCommand sqlPedidosId = new SqlCommand(consultaPedidosIdQuery, conexionAlmacenSql);

            SqlDataAdapter adpatadorSegmentosPorPasillo = new SqlDataAdapter(sqlPedidosId);

            using (adpatadorSegmentosPorPasillo)
            {
                sqlPedidosId.Parameters.AddWithValue("@PedidoId", listaPedidos.SelectedValue);

                DataTable tablaPedidosId = new DataTable();

                adpatadorSegmentosPorPasillo.Fill(tablaPedidosId);

                listaPedidosPedido.DisplayMemberPath = "EAN_linea_pedido";
                listaPedidosPedido.SelectedValuePath = "EAN_linea_pedido";
                listaPedidosPedido.ItemsSource = tablaPedidosId.DefaultView;
            }
        }

        private void listaPasillos_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            consultaSegmentosPorPasillo();
        }

        private void listaFechas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            consultaPedidosFecha();
        }

        private void listaPedidos_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            consultaPedidosId();
        }

        private void listaPedidos0301_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            consultaPedidosFechaPrueba();
        }
    }
}
