package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.CampoDTO")]
	public class CampoDTO extends AbstractDTO
	{
		private var _id:Number;
		private var _descricao:String;
		private var _valorPadrao:String;
		private var _comentario:String;
		private var _tamanho:Number;
		private var _naoNulo:Boolean;
		private var _autoIncremento:Boolean;
		private var _chavePrimaria:Boolean;
		private var _tabela:TabelaDTO;
		private var _tabelaEstrangeira:TabelaDTO;
		private var _tipo:TipoCampoDTO;
		
		public function CampoDTO()
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
		
		public function get descricao():String
		{
			return _descricao;
		}
		
		public function set descricao(value:String):void 
		{
			_descricao = value;
		}
		
		public function get valorPadrao():String
		{
			return _valorPadrao;
		}
		
		public function set valorPadrao(value:String):void 
		{
			_valorPadrao = value;
		}
		
		public function get comentario():String
		{
			return _comentario;
		}
		
		public function set comentario(value:String):void 
		{
			_comentario = value;
		}

		public function get tamanho():Number
		{
			return _tamanho;
		}	
			
		public function set tamanho(value:Number):void
		{
			_tamanho = value;
		}
		
		public function get naoNulo():Boolean
		{
			return _naoNulo;
		}
		
		public function set naoNulo(value:Boolean):void 
		{
			_naoNulo = value;
		}
		
		public function get autoIncremento():Boolean
		{
			return _autoIncremento;
		}
		
		public function set autoIncremento(value:Boolean):void 
		{
			_autoIncremento = value;
		}

		public function get chavePrimaria():Boolean
		{
			return _chavePrimaria;
		}
		
		public function set chavePrimaria(value:Boolean):void 
		{
			_chavePrimaria = value;
		}
		
		public function get tabela():TabelaDTO
		{
			return _tabela;
		}
		
		public function set tabela(value:TabelaDTO):void 
		{
			_tabela = value;
		}
		
		public function get tabelaEstrangeira():TabelaDTO
		{
			return _tabelaEstrangeira;
		}
		
		public function set tabelaEstrangeira(value:TabelaDTO):void 
		{
			_tabelaEstrangeira = value;
		}
		
		public function get tipo():TipoCampoDTO
		{
			return _tipo;
		}
		
		public function set tipo(value:TipoCampoDTO):void 
		{
			_tipo = value;
		}


	}
}