using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionPedidos
{
    class Pasillo
    {
        public string idPasillo { get; set; }
        public string idAreaPasillo { get; set; }
        public int longitud { get; set; }
        public int anchura { get; set; }
        public List<Segmento> segmento { get; set; }

        public Pasillo() { }

        public Pasillo(string idPasillo, string idAreaPasillo, int longitud, int anchura, List<Segmento> segmento)
        {
            this.idPasillo = idPasillo;
            this.idAreaPasillo = idAreaPasillo;
            this.longitud = longitud;
            this.anchura = anchura;
            this.segmento = segmento;
        }
    }
}
