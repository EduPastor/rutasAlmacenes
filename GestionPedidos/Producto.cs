using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionPedidos
{
    class Producto
    {

        public int EAN { get; set; }
        public string categoriaProducto { get; set; }
        public string nombre { get; set; }
        public int anchura { get; set; }
        public int longitud { get; set; }
        public int profundidad { get; set; }
    }
}
