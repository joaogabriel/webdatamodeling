package br.edu.ucb.webdatamodeling.dto
{
	[RemoteClass(alias="br.edu.ucb.webdatamodeling.dto.TipoArquivoDTO")]
	public class TipoArquivoDTO extends AbstractDTO
	{
		
		private var _id:Number;
		private var _descricao:String;
		
		public function TipoArquivoDTO()
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

	}
}