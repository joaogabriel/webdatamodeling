package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.MerDTO")]
	public class MerDTO
	{
		
		private var _id:Number;
		private var _exportado:Boolean;
		private var _dataUltimaExportacao:Date;
		private var _arquivo:Number;
		private var _tabelas:Array;
		private var _usuarios:Array;
		
		public function MerDTO()
		{
		}

		public function get id():Number
		{
			return _id;
		}
		
		public function set id(value:Number):void 
		{
			_id = value;
		}
		
		public function get exportado():Boolean
		{
			return _exportado;
		}
		
		public function set exportado(value:Boolean):void 
		{
			_exportado = value;
		}
		
		public function get dataUltimaExportacao():Date
		{
			return _dataUltimaExportacao;
		}
		
		public function set dataUltimaExportacao(value:Date):void 
		{
			_dataUltimaExportacao = value;
		}
		
		public function get arquivo():Number
		{
			return _arquivo;
		}
		
		public function set arquivo(value:Number):void 
		{
			_arquivo = value;
		}

		public function get tabelas():Array
		{
			return _tabelas;
		}
		
		public function set tabelas(value:Array):void 
		{
			_tabelas = value;
		}

		public function get usuarios():Array
		{
			return _usuarios;
		}
		
		public function set usuarios(value:Array):void 
		{
			_usuarios = value;
		}

	}
}