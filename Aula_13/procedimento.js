// CRIA O BANCO
use biblioteca

// CRIA AS COLEÇÕES
db.createCollection("usuarios");
db.createCollection("livros");

// EXIBE AS COLEÇÕES
show collections;


// CRIA AS VALIDAÇÕES DOS CAMPOS
db.runCommand({ collMod: "usuarios",
  validator: { $jsonSchema: {
    required: ["nome", "ra",
               "email", "curso"],
    properties: {
      multa: { minimum: 0 } } } }
});

// MODIFICA OS CAMPOS PARA MANTÊ-LOS ÚNICOS
db.usuarios.createIndex(
  { email: 1 }, { unique: true }
);

db.usuarios.createIndex(
  { ra: 1 }, { unique: true }
);


// INSERIR REGISTROS
db.livros.insertOne([
  { _id: 1, 
	titulo: "Torto Arado", 
	autor: "Itamar Vieira Junior", 
	ano: 2019,
    	isbn: "978-8-6999-3867-7", 
	editora: { nome: "Record", cidade: "Rio de Janeiro" },
	qtd_exemplares: 3, 
	qtd_disponivel: 3 }
]);


db.livros.insertMany([
   { _id: 2, 
	titulo: "A Menina que Roubava Livros (3ª edição)", 
	autor: "Markus Zusak", 
	ano: 2009,
	isbn: "978-2-9014-7679-7", 
	editora: { nome: "Rocco", 
	cidade: "Rio de Janeiro" },
    	qtd_exemplares: 4, 
	qtd_disponivel: 4 },
   { _id: 3, 
	titulo: "O Sol é para Todos (4ª edição)", 
	autor: "Harper Lee", 
	ano: 1966,
	isbn: "978-3-0515-2204-7", 
	editora: { nome: "Sextante", 
	cidade: "Rio de Janeiro" },
    	qtd_exemplares: 2,
	qtd_disponivel: 2 }
]);

db.usuarios.insertOne({
  _id: 1, nome: "Amanda Duarte Araújo", ra: 20251420,
  	email: "amanda.duarte122@email.com", 
  	multa: 0,
  	curso: { nome: "Ciência da Computação", turno: "Noturno" },
  	emprestimos: [
		{ livro_id: 1, 
			titulo: "Torto Arado",
		  	retirada: new Date("2026-07-04"), prevista: new Date("2026-07-19"),
	      		devolucao: new Date("2026-07-17") },
    		{ livro_id: 2, 
			titulo: "A Menina que Roubava Livros (3ª edição)",
	      		retirada: new Date("2026-08-01"), prevista: new Date("2026-08-16"),
	      		devolucao: new Date("2026-08-16") }]
});


db.usuarios.insertOne({
  _id: 2, nome: "Lucas Lobo Azenha", ra: 20251423,
  	email: "lucas.la22@email.com", 
  	multa: 0,
  	curso: { nome: "Ciência da Computação", turno: "Noturno" },
  	emprestimos: [
		{ livro_id: 1, 
			titulo: "Torto Arado",
		  	retirada: new Date("2026-07-04"), prevista: new Date("2026-07-19"),
	      		devolucao: new Date("2026-07-17") },
    		{ livro_id: 2, 
			titulo: "A Menina que Roubava Livros (3ª edição)",
	      		retirada: new Date("2026-08-01"), prevista: new Date("2026-08-16"),
	      		devolucao: new Date("2026-08-16") }]
});

db.usuarios.insertOne({
  _id: 3, nome: "Patrícia Faria", ra: 20221423,
  	email: "patty.faria76@email.com", 
  	multa: 0,
  	curso: { nome: "Direito", turno: "Noturno" },
  	emprestimos: [
		{ livro_id: 1, 
			titulo: "Torto Arado",
		  	retirada: new Date("2026-07-04"), prevista: new Date("2026-07-19"),
	      		devolucao: new Date("2026-07-17") },
    		{ livro_id: 2, 
			titulo: "A Menina que Roubava Livros (3ª edição)",
	      		retirada: new Date("2026-08-01"), prevista: new Date("2026-08-16"),
	      		devolucao: new Date("2026-08-16") }]
});

//CONSULTAS

db.usuarios.find();
db.usuarios.findOne({ _id: 1 });

db.usuarios.find(
  { "curso.turno": "Noturno" },  
  { nome: 1, _id: 0 }           
).sort({ nome: 1 });

db.livros.find(
   { ano: { $gt: 1960 } }, 
   { titulo: 1, ano: 1, _id: 0 }
).sort({ ano: 1 });

db.usuarios.find(
  { "emprestimos.livro_id": 1 },
  { nome: 1 }
);


db.usuarios.aggregate([
  { $unwind: "$emprestimos" },
  { $group: { _id: "$curso.nome",
              total: { $sum: 1 } } },
  { $sort: { total: -1 } }
]);


db.usuarios.aggregate([
  { $match: { _id: 2 } },
  { $unwind: "$emprestimos" },
  { $lookup: { from: "livros",
      localField: "emprestimos.livro_id",
      foreignField: "_id", as: "livro" } }
]);




db.usuarios.aggregate([
  { $match: { _id: 2 } },
  { $unwind: "$emprestimos" },
  { $lookup: { from: "livros",
      localField: "emprestimos.livro_id",
      foreignField: "_id", as: "livro" } },
  { $unwind: "$livro" },                       
  { $project: {
      _id: 0,                                  
      nome: 1,                                 
      titulo: "$livro.titulo",                 
      autor: "$livro.autor",
      editora: "$livro.editora.nome",
      cidade: "$livro.editora.cidade",          
      retirada: "$emprestimos.retirada"
  } }
]);

//ALTERAÇÃO
db.usuarios.updateOne(
  { _id: 1 },
  { $set: { email: "amanda.duarte1989@email.com" } }
);

//DELETAR REGISTROS
db.livros.deleteOne({ _id: 14 });




