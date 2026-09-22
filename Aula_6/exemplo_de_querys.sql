-- AULA 06

-- exemplo 1 LEFT VS. RIGHT
select *
from livro_has_usuario hs
right join usuario us on us.pk_usuario_id = hs.fk_usuario_id
where hs.fk_usuario_id is null;

select * 
from usuario us
left join livro_has_usuario hs on hs.fk_usuario_id = us.pk_usuario_id
where hs.fk_usuario_id is null;

-- Exemplo 2 LEFT JOIN
select  count(*) -- us.nome, us.ra, has.fk_usuario_id, has.fk_livro_id
from usuario us
left join livro_has_usuario has on has.fk_usuario_id = us.pk_usuario_id
where has.fk_usuario_id is null;

-- Exemplo 3 INNER JOIN
select us.nome as 'Nome', us.ra as 'RA', cs.nome as 'Curso' 
from usuario us
inner join curso cs on cs.pk_curso_id = us.fk_curso_id
where cs.pk_curso_id =1
order by us.nome;

-- exemplo 4 GROUP BY e HAVING
select cs.nome as 'Curso', count(*) as 'Qtd. matriculados' 
from usuario us
inner join curso cs on cs.pk_curso_id = us.fk_curso_id
group by cs.pk_curso_id, cs.nome
having count(*) > 10
order by count(*) desc;


-- exemplo 5 SUB QUERY
select cs.nome as 'Curso', qtd_matriculados as 'Qtd'
from (
select fk_curso_id, count(*) as qtd_matriculados
from usuario 
group by fk_curso_id
having qtd_matriculados >10 ) us
inner join curso cs on cs.pk_curso_id = us.fk_curso_id
order by qtd_matriculados desc;

