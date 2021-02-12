using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionPedidos
{
    class Caja
    {

        public Caja(int idCaja, string categoriaCaja, int anchura, int longitud, int profundidad)
        {
            this.idCaja = idCaja;
            this.categoriaCaja = categoriaCaja;
            this.anchura = anchura;
            this.longitud = longitud;
            this.profundidad = profundidad;
        }

        public Caja() { }


        public int idCaja { get; set; }
        public string categoriaCaja { get; set; }
        public int anchura { get; set; }
        public int longitud { get; set; }
        public int profundidad { get; set; }
    }
}
