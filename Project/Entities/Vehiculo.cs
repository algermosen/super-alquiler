﻿using System;
using Radzen;

namespace SuperAlquiler.Entities
{
    public class Vehiculo : EntidadBase, IClonador<Vehiculo>
    {
        public Vehiculo()
        {
            TipoVehiculo = new TipoVehiculo();
        }
        public string Marca { get; set; }
        public string Modelo { get; set; }
        public string Matricula { get; set; }
        public string NoSeguro { get; set; }
        public int Year { get; set; }
        public double PrecioPorDia { get; set; }
        public double CapacidadDeCarga { get; set; }

        public TipoVehiculo TipoVehiculo { get; set; }
        public string Color { get; set; }
        public double Latitud { get; set; }
        public double Longitud { get; set; }
        public int Pasajeros { get; set; }
        public string Foto { get; set; }
        public string Ubicacion {
            get
            {
                return $"{Latitud}, {Longitud}";
            }
        }

        private GoogleMapPosition _posicion = new GoogleMapPosition();
        public GoogleMapPosition Posicion
        {
            get
            {
                _posicion.Lat = Latitud;
                _posicion.Lng = Longitud;
                return _posicion;
            }
        }

        public override string ToString()
        {
            return $"[{Matricula}] {Marca}-{Modelo} {Color}";
        }

        public Vehiculo Clonar()
        {
            Vehiculo vehiculo = (Vehiculo)MemberwiseClone();
            vehiculo.TipoVehiculo = new TipoVehiculo { Id = TipoVehiculo.Id };
            return vehiculo;
        }
    }
}
