package br.edu.ucb.webdatamodeling.dto
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.MerDTO")]
	public class MerDTO extends AbstractDTO
	{
		
		private var _id:Number;
		private var _exportado:Boolean;
		private var _dataUltimaExportacao:Date;
		private var _arquivo:ArquivoDTO;
		private var _tabelas:ArrayCollection;
		private var _usuarios:ArrayCollection;
		private var _notas:ArrayCollection;
		
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
		
		public function get arquivo():ArquivoDTO
		{
			return _arquivo;
		}
		
		public function set arquivo(value:ArquivoDTO):void 
		{
			_arquivo = value;
		}

		public function get tabelas():ArrayCollection
		{
			return _tabelas;
		}
		
		public function set tabelas(value:ArrayCollection):void 
		{
			_tabelas = value;
		}

		public function get usuarios():ArrayCollection
		{
			return _usuarios;
		}
		
		public function set usuarios(value:ArrayCollection):void 
		{
			_usuarios = value;
		}
		
		public function get notas():ArrayCollection
		{
			return _notas;
		}
		
		public function set notas(notas:ArrayCollection):void
		{
			_notas = notas;
		}

	}
}