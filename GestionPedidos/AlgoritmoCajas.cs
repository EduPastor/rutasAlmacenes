using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CromulentBisgetti.ContainerPacking.Algorithms;
using CromulentBisgetti.ContainerPacking.Entities;
using CromulentBisgetti.ContainerPacking;

namespace GestionPedidos
{
    class AlgoritmoCajas
    {
        SqlConnection conexionAlmacenSql;

        string consultaTotalElementosPedido = "SELECT * FROM producto P inner join linea_pedido LP ON P.EAN = LP.EAN_linea_pedido WHERE LP.id_pedido_linea_pedido = @PedidoId";

        public int calculoCajasProducto(int numproductos)
        {

            var numCajas = 0;
            if (numproductos > 0) numCajas = numproductos / 20 + 1;
            return numCajas;

        }

        public List<Caja> algoritmoCajasOptimizado(Pedido pedidoAOptimizar)
        {

            //conexion con la BBDD
            string conexionAlmacen = ConfigurationManager.ConnectionStrings["GestionPedidos.Properties.Settings.almacenConnectionString"].ConnectionString;

            //instanciamos el objeto de conexion
            conexionAlmacenSql = new SqlConnection(conexionAlmacen);

            List<ProductoPedido> productosPedido = getNumeroPedidosId(pedidoAOptimizar.id_pedido);
            List<Caja> result = optimizador(productosPedido);

            return result;

        }

        public List<Caja> optimizador(List<ProductoPedido> productos)
        {

            List<Container> containersAux = new List<Container>();
            List<CajaOptimizada> result = new List<CajaOptimizada>();
            List<Caja> resultToReturn = new List<Caja>();
            List<int> algorithms = new List<int>();
            algorithms.Add((int)AlgorithmType.EB_AFIT);
            List<Item> itemsToPackAmbiente = new List<Item>();
            List<Item> itemsToPackRefrigerado = new List<Item>();
            List<Item> itemsToPackCongelado = new List<Item>();
            List<Item> itemsToPackVoluminoso = new List<Item>();
            List<ProductoPedido> pedidosAmbiente = new List<ProductoPedido>();
            List<ProductoPedido> pedidosRefrigerado = new List<ProductoPedido>();
            List<ProductoPedido> pedidosCongelado = new List<ProductoPedido>();
            List<ProductoPedido> pedidosVoluminoso = new List<ProductoPedido>();
            foreach (ProductoPedido productoAux in productos)
            {

                if (productoAux.producto.categoriaProducto == "AMBIENTE")
                {
                    pedidosAmbiente.Add(productoAux);
                }

                else if (productoAux.producto.categoriaProducto == "REFRIGERADO")
                {
                    pedidosRefrigerado.Add(productoAux);
                }

                else if (productoAux.producto.categoriaProducto == "CONGELADO")
                {
                    pedidosCongelado.Add(productoAux);
                }

                else if (productoAux.producto.categoriaProducto == "VOLUMINOSO")
                {
                    pedidosVoluminoso.Add(productoAux);
                }

            }

            foreach (var productosAmbiente in pedidosAmbiente)
            {
                itemsToPackAmbiente.Add(new Item(productosAmbiente.producto.EAN, productosAmbiente.producto.anchura, productosAmbiente.producto.longitud, productosAmbiente.producto.profundidad, productosAmbiente.cantidad));
            }

            foreach (var productosRefrigerado in pedidosRefrigerado)
            {
                itemsToPackRefrigerado.Add(new Item(productosRefrigerado.producto.EAN, productosRefrigerado.producto.anchura, productosRefrigerado.producto.longitud, productosRefrigerado.producto.profundidad, productosRefrigerado.cantidad));
            }

            foreach (var productosCongelado in pedidosCongelado)
            {
                itemsToPackCongelado.Add(new Item(productosCongelado.producto.EAN, productosCongelado.producto.anchura, productosCongelado.producto.longitud, productosCongelado.producto.profundidad, productosCongelado.cantidad));
            }

            foreach (var productosVoluminoso in pedidosVoluminoso)
            {
                itemsToPackVoluminoso.Add(new Item(productosVoluminoso.producto.EAN, productosVoluminoso.producto.anchura, productosVoluminoso.producto.longitud, productosVoluminoso.producto.profundidad, productosVoluminoso.cantidad));
            }

            List<CajaOptimizada> cajaOptimizadaAux = new List<CajaOptimizada>();
            List<CajaOptimizada> cajaOptimizadaUnpacked = new List<CajaOptimizada>();

            if (itemsToPackAmbiente.Count > 0)
            {
                cajaOptimizadaAux = numCajasTipo(containersAux, itemsToPackAmbiente, algorithms, "AMBIENTE");
                foreach (var CajaAux in cajaOptimizadaAux)
                {
                    resultToReturn.Add(CajaAux.caja);

                    if (CajaAux.itemsToPackUnpacked.Count > 0)
                    {
                        List<Item> xxx = new List<Item>();
                        itemsToPackRefrigerado.Clear();

                        foreach (Item item in CajaAux.itemsToPackUnpacked)
                        {
                            xxx.Add(new Item(item.ID, item.Dim1, item.Dim2, item.Dim3, item.Quantity));
                        }

                        cajaOptimizadaUnpacked = numCajasTipo(containersAux, xxx, algorithms, "AMBIENTE");
                        resultToReturn.Add(cajaOptimizadaUnpacked[0].caja);
                    }
                }
            }

            if (itemsToPackRefrigerado.Count > 0)
            {
                cajaOptimizadaAux = numCajasTipo(containersAux, itemsToPackRefrigerado, algorithms, "REFRIGERADO");
                foreach (var CajaAux in cajaOptimizadaAux)
                {
                    resultToReturn.Add(CajaAux.caja);

                    if (CajaAux.itemsToPackUnpacked.Count > 0)
                    {
                        List<Item> xxx = new List<Item>();
                        itemsToPackRefrigerado.Clear();

                        foreach (Item item in CajaAux.itemsToPackUnpacked)
                        {
                            xxx.Add(new Item(item.ID, item.Dim1, item.Dim2, item.Dim3, item.Quantity));
                        }

                        cajaOptimizadaUnpacked = numCajasTipo(containersAux, xxx, algorithms, "REFRIGERADO");
                        resultToReturn.Add(cajaOptimizadaUnpacked[0].caja);
                    }
                }

            }
            if (itemsToPackCongelado.Count > 0)
            {
                cajaOptimizadaAux = numCajasTipo(containersAux, itemsToPackCongelado, algorithms, "CONGELADO");

                foreach (var CajaAux in cajaOptimizadaAux)
                {
                    resultToReturn.Add(CajaAux.caja);

                    if (CajaAux.itemsToPackUnpacked.Count > 0)
                    {
                        List<Item> xxx = new List<Item>();
                        itemsToPackRefrigerado.Clear();

                        foreach (Item item in CajaAux.itemsToPackUnpacked)
                        {
                            xxx.Add(new Item(item.ID, item.Dim1, item.Dim2, item.Dim3, item.Quantity));
                        }

                        cajaOptimizadaUnpacked = numCajasTipo(containersAux, xxx, algorithms, "CONGELADO");
                        resultToReturn.Add(cajaOptimizadaUnpacked[0].caja);
                    }
                }
            }
            if (itemsToPackVoluminoso.Count > 0)
            {
                cajaOptimizadaAux = numCajasTipo(containersAux, itemsToPackVoluminoso, algorithms, "VOLUMINOSO");

                foreach (var CajaAux in cajaOptimizadaAux)
                {
                    resultToReturn.Add(CajaAux.caja);

                    if (CajaAux.itemsToPackUnpacked.Count > 0)
                    {
                        List<Item> xxx = new List<Item>();
                        itemsToPackRefrigerado.Clear();

                        foreach (Item item in CajaAux.itemsToPackUnpacked)
                        {
                            xxx.Add(new Item(item.ID, item.Dim1, item.Dim2, item.Dim3, item.Quantity));
                        }

                        cajaOptimizadaUnpacked = numCajasTipo(containersAux, xxx, algorithms, "VOLUMINOSO");
                        resultToReturn.Add(cajaOptimizadaUnpacked[0].caja);
                    }
                }
            }

            return resultToReturn;

        }

        private List<CajaOptimizada> numCajasTipo(List<Container> containersAux, List<Item> itemsToPackAux, List<int> algorithms, String tipoCaja)
        {
            List<CajaOptimizada> result = new List<CajaOptimizada>();
            Caja cajaAux = new Caja();

            if (tipoCaja == "AMBIENTE")
            {
                containersAux.Clear();
                cajaAux = new Caja(1, "AMBIENTE", 40, 60, 40);
                containersAux.Add(new Container(1, cajaAux.longitud, cajaAux.anchura, cajaAux.profundidad));
            }

            else if (tipoCaja == "REFRIGERADO")
            {
                containersAux.Clear();
                cajaAux = new Caja(1, "REFRIGERADO", 34, 52, 34);
                containersAux.Add(new Container(1, cajaAux.longitud, cajaAux.anchura, cajaAux.profundidad));
            }

            else if (tipoCaja == "CONGELADO")
            {
                containersAux.Clear();
                cajaAux = new Caja(1, "CONGELADO", 32, 52, 32);
                containersAux.Add(new Container(1, cajaAux.longitud, cajaAux.anchura, cajaAux.profundidad));
            }

            else if (tipoCaja == "VOLUMINOSO")
            {
                containersAux.Clear();
                cajaAux = new Caja(1, "VOLUMINOSO", 40, 60, 40);
                containersAux.Add(new Container(1, cajaAux.longitud, cajaAux.anchura, cajaAux.profundidad));
            }

            List<ContainerPackingResult> resultOpti = PackingService.Pack(containersAux, itemsToPackAux, algorithms);

            foreach (var listaCajasOptimizadas in resultOpti)
            {
                List<AlgorithmPackingResult> cajasOprimizadas = listaCajasOptimizadas.AlgorithmPackingResults;

                foreach (var cajaOptimizada in cajasOprimizadas)
                {
                    CajaOptimizada cajaOptimizadaAux = new CajaOptimizada();
                    cajaOptimizadaAux.caja = cajaAux;
                    cajaOptimizadaAux.itemsToPackUnpacked = cajaOptimizada.UnpackedItems;
                    result.Add(cajaOptimizadaAux);
                }
            }

            return result;

        }

        private List<ProductoPedido> getNumeroPedidosId(int pedidoId)
        {
            List<ProductoPedido> listProductosPedido = new List<ProductoPedido>();
            conexionAlmacenSql.Open();
            SqlCommand consultaPedidosPruebaRefrigerado = new SqlCommand(consultaTotalElementosPedido, conexionAlmacenSql);
            consultaPedidosPruebaRefrigerado.Parameters.AddWithValue("@PedidoId", pedidoId);
            using (SqlDataReader reader = consultaPedidosPruebaRefrigerado.ExecuteReader())
            {

                while (reader.Read())
                {

                    Producto productoAux = new Producto();
                    ProductoPedido productoPedidoAux = new ProductoPedido();
                    productoAux.EAN = reader.GetInt32(0);
                    productoAux.categoriaProducto = reader.GetString(1);
                    productoAux.longitud = reader.GetInt32(3);
                    productoAux.anchura = reader.GetInt32(4);
                    productoAux.profundidad = reader.GetInt32(5);
                    productoPedidoAux.producto = productoAux;
                    productoPedidoAux.cantidad = reader.GetInt32(8);
                    listProductosPedido.Add(productoPedidoAux);

                }

            }

            conexionAlmacenSql.Close();
            return listProductosPedido;

        }

    }

}