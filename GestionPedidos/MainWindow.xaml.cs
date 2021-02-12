using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        SqlConnection conexionAlmacenSql;
        string consultaIdPedidosFecha0301 = "SELECT (id_pedido) FROM pedido WHERE fecha ='2021-01-03'";
        string consultaProductosPedidosId = "SELECT CONCAT (EAN, ' - ', categoria_producto, ' - ', nombre, ' - ', EAN_linea_pedido, ' - ', id_pedido_linea_pedido, ' - ', cantidad ) AS PEDIDOSCOMPLETOS FROM producto A inner join linea_pedido LP ON A.EAN = LP.EAN_linea_pedido WHERE LP.id_pedido_linea_pedido = @PedidoId";
        string consultaTotalElementosPedido = "SELECT SUM(cantidad) FROM producto P inner join linea_pedido LP ON P.EAN = LP.EAN_linea_pedido WHERE LP.id_pedido_linea_pedido = @PedidoId AND P.categoria_producto = @PedidoTipo";
        string consultaPedidosFechaQuery = "SELECT id_pedido FROM pedido WHERE fecha = '2021-01-03'";

        public MainWindow()
        {

            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);

            InitializeComponent();
            consultaPedidos3102();
            idPedidos3102();
            
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            PantallaPrueba pantallaP = new PantallaPrueba();
            pantallaP.Show();
        }

        private void consultaPedidos3102()
        {
            SqlDataAdapter adpatadorPedidosFechaPrueba = new SqlDataAdapter(consultaIdPedidosFecha0301, conexionAlmacenSql);

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

            int numProductosPedidoAmbiente = 0;
            int numProductosPedidoRefrigerado = 0;
            int numProductosPedidoCongelado = 0;
            int numProductosPedidoVoluminoso = 0;
            int numCajasPedidoAmbiente = 0;
            int numCajasPedidoRefrigerado = 0;
            int numCajasPedidoCongelado = 0;
            int numCajasPedidoVoluminoso = 0;
            int numProductosPedidoTotal = 0;
            int totalCajasPedidoAmbiente = 0;
            int totalCajasPedidoRefrigerado = 0;
            int totalCajasPedidoCongelado = 0;
            int totalCajasPedidoVoluminoso = 0;

            AlgoritmoCajas algoritmo = new AlgoritmoCajas();

            SqlCommand sqlPedidosFecha = new SqlCommand(consultaProductosPedidosId, conexionAlmacenSql);

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

            numProductosPedidoAmbiente = getNumeroPedidosIdTipo(int.Parse(listaPedidos0301.SelectedValue.ToString()), "AMBIENTE");
            labelProductosPedidoAmbiente.Content = numProductosPedidoAmbiente;

            numProductosPedidoRefrigerado = getNumeroPedidosIdTipo(int.Parse(listaPedidos0301.SelectedValue.ToString()), "REFRIGERADO");
            labelProductosPedidoRefrigerado.Content = numProductosPedidoRefrigerado;

            numProductosPedidoCongelado = getNumeroPedidosIdTipo(int.Parse(listaPedidos0301.SelectedValue.ToString()), "CONGELADO");
            labelProductosPedidoCongelado.Content = numProductosPedidoCongelado;

            numProductosPedidoVoluminoso = getNumeroPedidosIdTipo(int.Parse(listaPedidos0301.SelectedValue.ToString()), "VOLUMINOSO");
            labelProductosPedidoVoluminoso.Content = numProductosPedidoVoluminoso;

            numProductosPedidoTotal = numProductosPedidoAmbiente + numProductosPedidoRefrigerado + numProductosPedidoCongelado + numProductosPedidoVoluminoso;
            labelProductosPedidoTotal.Content = numProductosPedidoTotal;

            numCajasPedidoAmbiente = algoritmo.calculoCajasProducto(numProductosPedidoAmbiente);
            labelCajasAmbiente.Content = numCajasPedidoAmbiente;

            numCajasPedidoRefrigerado = algoritmo.calculoCajasProducto(numProductosPedidoRefrigerado);
            labelCajasRefrigerado.Content = numCajasPedidoRefrigerado;

            numCajasPedidoCongelado = algoritmo.calculoCajasProducto(numProductosPedidoCongelado);
            labelCajasCongelado.Content = numCajasPedidoCongelado;

            numCajasPedidoVoluminoso = algoritmo.calculoCajasProducto(numProductosPedidoVoluminoso);
            labelCajasVolumioso.Content = numCajasPedidoVoluminoso;

            labelCajasTotal.Content = numCajasPedidoAmbiente + numCajasPedidoRefrigerado + numCajasPedidoCongelado + numCajasPedidoVoluminoso;

            List<Caja> cajas = new List<Caja>();
            Pedido pedido = new Pedido();
            pedido.id_pedido = int.Parse(listaPedidos0301.SelectedValue.ToString());
            AlgoritmoCajas algoritmoCajas = new AlgoritmoCajas();
            cajas.AddRange(algoritmoCajas.algoritmoCajasOptimizado(pedido));
            foreach (var caja in cajas)
            {
                if (caja.categoriaCaja == "AMBIENTE")
                {
                    totalCajasPedidoAmbiente++;
                }
                else if (caja.categoriaCaja == "REFRIGERADO")
                {
                    totalCajasPedidoRefrigerado++;
                }
                else if (caja.categoriaCaja == "CONGELADO")
                {
                    totalCajasPedidoCongelado++;
                }
                else if (caja.categoriaCaja == "VOLUMINOSO")
                {
                    totalCajasPedidoVoluminoso++;
                }
            }
            labelCajasAlgoritmoAmbiente.Content = totalCajasPedidoAmbiente;
            labelCajasAlgoritmoRefrigerado.Content = totalCajasPedidoRefrigerado;
            labelCajasAlgoritmoCongelado.Content = totalCajasPedidoCongelado;
            labelCajasAlgoritmoVoluminoso.Content = totalCajasPedidoVoluminoso;

        }

        private int getNumeroPedidosIdTipo(int pedidoId, string PedidoTipo)
        {

            int numProductosPedido = 0;
            conexionAlmacenSql.Open();
            SqlCommand consultaPedidosPruebaRefrigerado = new SqlCommand(consultaTotalElementosPedido, conexionAlmacenSql);
            consultaPedidosPruebaRefrigerado.Parameters.AddWithValue("@PedidoId", pedidoId);
            consultaPedidosPruebaRefrigerado.Parameters.AddWithValue("@PedidoTipo", PedidoTipo);
            using (SqlDataReader reader = consultaPedidosPruebaRefrigerado.ExecuteReader())
            {

                if (reader.Read() && !reader.IsDBNull(0))
                {
                    numProductosPedido = numProductosPedido + reader.GetInt32(0);
                }
                    
            }
            conexionAlmacenSql.Close();
            return numProductosPedido;
        }

        private int idPedidos3102()
        {

            int numPedidos = 0;
            int totalProductosPedidoAmbiente = 0;
            int totalProductosPedidoRefrigerado = 0;
            int totalProductosPedidoCongelado = 0;
            int totalProductosPedidoVoluminoso = 0;
            int totalCajasPedidoAmbiente = 0;
            int totalCajasPedidoRefrigerado = 0;
            int totalCajasPedidoCongelado = 0;
            int totalCajasPedidoVoluminoso = 0;
            int auxAmbiente;
            int auxRefrigerado;
            int auxCongelado;
            int auxVoluminoso;
            AlgoritmoCajas algoritmoCajas = new AlgoritmoCajas();
            conexionAlmacenSql.Open();
            List<Pedido> pedidos = new List<Pedido>();
            SqlCommand consultaPedidosPruebaRefrigerado = new SqlCommand(consultaPedidosFechaQuery, conexionAlmacenSql);
            using (SqlDataReader reader = consultaPedidosPruebaRefrigerado.ExecuteReader())
            {

               while (reader.Read())
                {
                    Pedido pedidoAux = new Pedido();
                    pedidoAux.id_pedido = reader.GetInt32(0);
                    pedidos.Add(pedidoAux);
                }

            }
            conexionAlmacenSql.Close();
            foreach (var pedido in pedidos)
            {
                auxAmbiente = 0;
                auxRefrigerado = 0;
                auxCongelado = 0;
                auxVoluminoso = 0;
                auxAmbiente = getNumeroPedidosIdTipo(pedido.id_pedido, "AMBIENTE");
                totalProductosPedidoAmbiente += auxAmbiente;
                totalCajasPedidoAmbiente += algoritmoCajas.calculoCajasProducto(auxAmbiente);

                auxRefrigerado = getNumeroPedidosIdTipo(pedido.id_pedido, "REFRIGERADO");
                totalProductosPedidoRefrigerado += auxRefrigerado;
                totalCajasPedidoRefrigerado += algoritmoCajas.calculoCajasProducto(auxRefrigerado);

                auxCongelado = getNumeroPedidosIdTipo(pedido.id_pedido, "CONGELADO");
                totalProductosPedidoCongelado += auxCongelado;
                totalCajasPedidoCongelado += algoritmoCajas.calculoCajasProducto(auxCongelado);

                auxVoluminoso = getNumeroPedidosIdTipo(pedido.id_pedido, "VOLUMINOSO");
                totalProductosPedidoVoluminoso += auxVoluminoso;
                totalCajasPedidoVoluminoso += algoritmoCajas.calculoCajasProducto(auxVoluminoso);

            }
            labelProductosPedidoAmbienteCompleto.Content = totalProductosPedidoAmbiente;
            labelProductosPedidoRefrigeradoCompleto.Content = totalProductosPedidoRefrigerado;
            labelProductosPedidoCongeladoCompleto.Content = totalProductosPedidoCongelado;
            labelProductosPedidoVoluminosoCompleto.Content = totalProductosPedidoVoluminoso;
            labelCajasAmbienteCompleto.Content = totalCajasPedidoAmbiente;
            labelCajasRefrigeradoCompleto.Content = totalCajasPedidoRefrigerado;
            labelCajasCongeladoCompleto.Content = totalCajasPedidoCongelado;
            labelCajasVolumiosoCompleto.Content = totalCajasPedidoVoluminoso;
            labelCarrosCompleto.Content = (totalCajasPedidoAmbiente + totalCajasPedidoRefrigerado + totalCajasPedidoCongelado + totalCajasPedidoVoluminoso)/12 + 1;
            rutaSinOptimizar(pedidos);
            rutaOptimizadaOrdenSegmentos(pedidos);
            optimizadorRuta(pedidos);
            totalCajasPedidoAmbiente = 0;
            totalCajasPedidoRefrigerado = 0;
            totalCajasPedidoCongelado = 0;
            totalCajasPedidoVoluminoso = 0;

            List<Caja> cajas = new List<Caja>();

            foreach (var pedido in pedidos)
            {
                cajas.AddRange(algoritmoCajas.algoritmoCajasOptimizado(pedido));
            }

            foreach (var caja in cajas)
            {
                if (caja.categoriaCaja == "AMBIENTE") {
                    totalCajasPedidoAmbiente++; 
                }
                else if (caja.categoriaCaja == "REFRIGERADO")
                {
                    totalCajasPedidoRefrigerado++;
                }
                else if (caja.categoriaCaja == "CONGELADO")
                {
                    totalCajasPedidoCongelado++;
                }
                else if(caja.categoriaCaja == "VOLUMINOSO")
                {
                    totalCajasPedidoVoluminoso++;
                }
            }

            labelCajasAlgoritmoAmbienteCompleto.Content = totalCajasPedidoAmbiente;
            labelCajasAlgoritmoRefrigeradoCompleto.Content = totalCajasPedidoRefrigerado;
            labelCajasAlgoritmoCongeladoCompleto.Content = totalCajasPedidoCongelado;
            labelCajasAlgoritmoVoluminosoCompleto.Content = totalCajasPedidoVoluminoso;
            //labelCarrosAlgoritmoCompleto.Content = totalCajasPedidoAmbiente + totalCajasPedidoRefrigerado + totalCajasPedidoCongelado + totalCajasPedidoVoluminoso;
            
            return numPedidos;

        }

        private void rutaSinOptimizar(List<Pedido> pedidosAOptimizar)
        {

            AlgoritmoPasillos rutaSinOptimizar = new AlgoritmoPasillos();
            TextRutaSinOptmizar.Text = rutaSinOptimizar.rutaSinOptimizar(pedidosAOptimizar);
            
        }

        private void rutaOptimizadaOrdenSegmentos(List<Pedido> pedidosAOptimizar)
        {

            AlgoritmoPasillos rutaSinOptimizar = new AlgoritmoPasillos();
            TextRutaOptimizada.Text = rutaSinOptimizar.rutaOptimizadaOrdenSegmentos(pedidosAOptimizar);

        }
                

        private void listaPedidos0301_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            consultaPedidosFechaPrueba();
        }

        private void optimizadorRuta(List<Pedido> pedidosAOptimizar)
        {
            AlgoritmoPasillos rutaOptimizada = new AlgoritmoPasillos();
            rutaOptimizada.rutaOptimizadaAlgoritmoOptimo(pedidosAOptimizar);
            //TextRutaOptimizada.Text = rutaSinOptimizar.rutaOptimizadaOrdenSegmentos(pedidosAOptimizar);
        }
        
    }
}
