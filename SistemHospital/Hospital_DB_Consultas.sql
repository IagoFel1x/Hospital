-- SCRIPT COMPLETO: 4 SELECTs, 4 UPDATEs e 4 DELETEs

USE hospital_db;

-- PARTE 1: 4 EXEMPLOS DE CONSULTA (SELECT)

-- CONSULTA 1: Listar os médicos que realizaram mais consultas.
-- Demonstra o uso de JOIN, COUNT, GROUP BY e ORDER BY para criar um ranking de produtividade.
SELECT
    m.nome,
    m.especialidade,
    COUNT(c.id_consulta) AS total_de_consultas
FROM
    Medico m
JOIN
    Consulta c ON m.id_medico = c.id_medico
GROUP BY
    m.id_medico, m.nome, m.especialidade
ORDER BY
    total_de_consultas DESC;


-- CONSULTA 2: Encontrar todos os pacientes atualmente internados em um leito de 'UTI'.
-- Demonstra o JOIN entre múltiplas tabelas para filtrar por um status e tipo específico.
SELECT
    p.nome AS nome_paciente,
    l.numero AS numero_leito,
    l.tipo AS tipo_leito,
    i.data_inicio,
    i.motivo
FROM
    Paciente p
JOIN
    Internacao i ON p.id_paciente = i.id_paciente
JOIN
    Leito l ON i.id_leito = l.id_leito
WHERE
    l.status = 'Ocupado' AND l.tipo = 'UTI' AND i.data_fim IS NULL;


-- CONSULTA 3: Listar todos os hospitais onde um médico específico ('Dr. Carlos Andrade') trabalha.
-- Demonstra como navegar em uma tabela de relacionamento N:M (Medico_Hospital).
SELECT
    m.nome AS nome_medico,
    h.nome AS nome_hospital,
    h.endereco
FROM
    Medico m
JOIN
    Medico_Hospital mh ON m.id_medico = mh.id_medico
JOIN
    Hospital h ON mh.id_hospital = h.id_hospital
WHERE
    m.nome = 'Dr. Carlos Andrade'; -- Substituir pelo nome do médico desejado


-- CONSULTA 4: Obter o histórico completo de uma consulta: diagnóstico, exame e receita.
-- Demonstra um JOIN complexo para rastrear o fluxo de atendimento de um paciente específico.
SELECT
    p.nome AS paciente,
    m.nome AS medico,
    c.data AS data_consulta,
    c.diagnostico_geral,
    e.tipo_exame,
    d.descricao_med AS diagnostico_detalhado,
    med.nome AS medicamento,
    r.dosagem
FROM
    Paciente p
JOIN Consulta c ON p.id_paciente = c.id_paciente
JOIN Medico m ON c.id_medico = m.id_medico
LEFT JOIN Exame e ON c.id_consulta = e.id_consulta
LEFT JOIN Diagnostico d ON e.id_exame = d.id_exame
LEFT JOIN Receita r ON d.id_diagnostico = r.id_diagnostico
LEFT JOIN Medicamento med ON r.id_medicamento = med.id_medicamento
WHERE
    p.id_paciente = 1; -- Substituir pelo ID do paciente desejado


-- PARTE 2: 4 EXEMPLOS DE ATUALIZAÇÃO (UPDATE)

-- UPDATE 1: ATUALIZAR O ENDEREÇO DE UM PACIENTE
-- Cenário: O paciente 'João Silva' (id_paciente = 1) mudou de endereço.
-- Verificação (ANTES):
SELECT nome, endereco FROM Paciente WHERE id_paciente = 1;

UPDATE Paciente
SET endereco = 'Rua Nova das Flores, 456, Bairro Novo, Cidade Nova'
WHERE id_paciente = 1;

-- Verificação (DEPOIS):
SELECT nome, endereco FROM Paciente WHERE id_paciente = 1;


-- UPDATE 2: LIBERAR UM LEITO APÓS ALTA DE UM PACIENTE
-- Cenário: O paciente internado no leito 101 (id_leito = 1) recebeu alta.
-- A internação (id_internacao = 1) deve ser finalizada e o status do leito atualizado.
-- Verificação (ANTES):
SELECT * FROM Internacao WHERE id_internacao = 1;
SELECT * FROM Leito WHERE id_leito = 1;

UPDATE Internacao
SET data_fim = NOW() -- Define a data de fim para o momento atual
WHERE id_internacao = 1;

UPDATE Leito
SET status = 'Livre'
WHERE id_leito = 1;

-- Verificação (DEPOIS):
SELECT * FROM Internacao WHERE id_internacao = 1;
SELECT * FROM Leito WHERE id_leito = 1;


-- UPDATE 3: ADICIONAR UMA ALERGIA À FICHA MÉDICA DE UM PACIENTE
-- Cenário: Descobriu-se que a paciente 'Maria Costa' (id_paciente = 2) é alérgica a 'Penicilina'.
-- Verificação (ANTES):
SELECT id_ficha, alergias FROM FichaMedica WHERE id_paciente = 2;

UPDATE FichaMedica
SET alergias = CONCAT(IFNULL(alergias, ''), ' | Penicilina')
WHERE id_paciente = 2;

-- Verificação (DEPOIS):
SELECT id_ficha, alergias FROM FichaMedica WHERE id_paciente = 2;


-- UPDATE 4: ALTERAR O CARGO E TELEFONE DE UM FUNCIONÁRIO
-- Cenário: O funcionário 'Roberto Lima' (id_funcionario = 1) foi promovido a 'Gerente de TI' e mudou de telefone.
-- Verificação (ANTES):
SELECT nome, cargo, telefone FROM Funcionario WHERE id_funcionario = 1;

UPDATE Funcionario
SET
    cargo = 'Gerente de TI',
    telefone = '(11) 98765-4321'
WHERE
    id_funcionario = 1;

-- Verificação (DEPOIS):
SELECT nome, cargo, telefone FROM Funcionario WHERE id_funcionario = 1;


-- PARTE 3: 4 EXEMPLOS DE EXCLUSÃO (DELETE)
-- ATENÇÃO: Operações de DELETE em bancos de dados médicos são raras e perigosas.
-- Geralmente, os registros são inativados em vez de excluídos.
-- Os exemplos abaixo são para fins de demonstração técnica.

-- DELETE 1: Cancelar uma visita agendada.
-- Cenário: A visita com id_visita = 1 foi cancelada pelo visitante.
-- Verificação (ANTES):
SELECT * FROM Visita WHERE id_visita = 1;

DELETE FROM Visita
WHERE id_visita = 1;

-- Verificação (DEPOIS): A consulta não deve retornar nada.
SELECT * FROM Visita WHERE id_visita = 1;


-- DELETE 2: Desvincular um médico de um hospital.
-- Cenário: O 'Dr. Carlos Andrade' (id_medico = 1) não trabalha mais no 'Hospital Central' (id_hospital = 1).
-- Esta ação remove o relacionamento, não o médico nem o hospital.
-- Verificação (ANTES):
SELECT * FROM Medico_Hospital WHERE id_medico = 1 AND id_hospital = 1;

DELETE FROM Medico_Hospital
WHERE id_medico = 1 AND id_hospital = 1;

-- Verificação (DEPOIS): A consulta não deve retornar nada.
SELECT * FROM Medico_Hospital WHERE id_medico = 1 AND id_hospital = 1;


-- DELETE 3: Remover um medicamento obsoleto do catálogo.
-- Cenário: O medicamento 'ExemploRemedio' (id_medicamento = 10) foi descontinuado e nunca foi receitado.
-- IMPORTANTE: Esta ação falhará se o medicamento estiver vinculado a alguma receita (devido à FOREIGN KEY).
-- Verificação (ANTES):
SELECT * FROM Medicamento WHERE id_medicamento = 10;

DELETE FROM Medicamento
WHERE id_medicamento = 10;

-- Verificação (DEPOIS): A consulta não deve retornar nada.
SELECT * FROM Medicamento WHERE id_medicamento = 10;


-- DELETE 4: Excluir uma ambulância que foi retirada de serviço.
-- Cenário: A ambulância com placa 'XYZ-1234' (id_ambulancia = 1) foi vendida e não pertence mais ao hospital.
-- Verificação (ANTES):
SELECT * FROM Ambulancia WHERE id_ambulancia = 1;

DELETE FROM Ambulancia
WHERE id_ambulancia = 1;

-- Verificação (DEPOIS): A consulta não deve retornar nada.
SELECT * FROM Ambulancia WHERE id_ambulancia = 1;