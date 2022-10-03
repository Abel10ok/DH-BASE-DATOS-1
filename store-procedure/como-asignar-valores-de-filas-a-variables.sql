set  @var_categoria = "";
	SELECT CategoriaID INTO @var_categoria FROM categorias WHERE CategoriaID = 1;
  --  UPDATE productos SET UnidadesPedidas = UnidadesPedidas + (UnidadesPedidas / 100 * porcentaje) WHERE CategoriaID = var_categoria;

select @var_categoria;
