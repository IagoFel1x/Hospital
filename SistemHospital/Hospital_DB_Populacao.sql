-- SCRIPT DE POPULAÇÃO COMPLETO PARA O BANCO DE DADOS hospital_db
-- Garante que todas as consultas, atualizações e exclusões do script principal funcionem
-- e adiciona dados extras para um ambiente mais robusto.

USE hospital_db;

-- Inserindo dados em uma ordem que respeita as chaves estrangeiras (FOREIGN KEYs)

-- 1. Entidades primárias (sem dependências)
INSERT INTO Hospital (id_hospital, nome, endereco, telefone) VALUES
(1, 'Hospital Central da Cidade', 'Rua Principal, 123, Centro', '(11) 2222-3333'),
(2, 'Hospital Regional Norte', 'Avenida Norte, 456, Bairro Norte', '(81) 3333-4444');

INSERT INTO Medico (id_medico, nome, especialidade, crm, telefone, email) VALUES
(1, 'Dr. Carlos Andrade', 'Cardiologista', 'CRM/SP 12345', '(11) 99887-6543', 'carlos.andrade@emailmed.com'),
(2, 'Dra. Ana Souza', 'Clínico Geral', 'CRM/SP 54321', '(11) 98765-1234', 'ana.souza@emailmed.com'),
(3, 'Dr. Ricardo Lima', 'Ortopedista', 'CRM/RJ 67890', '(21) 95432-1098', 'ricardo.lima@emailmed.com');

INSERT INTO Paciente (id_paciente, nome, email, telefone, endereco, sexo, data_nascimento) VALUES
(1, 'João da Silva', 'joao.silva@email.com', '(11) 99999-1111', 'Rua Antiga, 123, Bairro Velho, Cidade Velha', 'M', '1985-05-20'), -- Endereço antigo para o UPDATE
(2, 'Maria Costa', 'maria.costa@email.com', '(21) 98888-2222', 'Avenida das Américas, 500', 'F', '1992-07-30'),
(3, 'Pedro Martins', 'pedro.martins@email.com', '(31) 97777-3333', 'Rua dos Inconfidentes, 1000', 'M', '1980-01-15'),
(4, 'Ana Clara Dias', 'anaclara.dias@email.com', '(11) 96666-4444', 'Alameda Santos, 1200, Apto 50', 'F', '2000-03-10'); -- Paciente para a UTI

INSERT INTO Leito (id_leito, numero, tipo, status) VALUES
(1, '101-A', 'UTI', 'Ocupado'), -- Leito para a alta e UPDATE
(2, '102-A', 'UTI', 'Ocupado'), -- Leito extra para a consulta de UTI
(3, '201-B', 'Quarto Particular', 'Livre'),
(4, '202-B', 'Quarto Particular', 'Livre'),
(5, '301-C', 'Enfermaria', 'Manutenção');

INSERT INTO Medicamento (id_medicamento, nome, fabricante, descricao) VALUES
(1, 'Sinvastatina 20mg', 'Farmaco Genérico', 'Medicamento para controle de colesterol.'),
(2, 'Paracetamol 750mg', 'Medley', 'Analgésico e antitérmico.'),
(3, 'Amoxicilina 500mg', 'EMS', 'Antibiótico.'),
(10, 'ExemploRemedio', 'Farmaco Antiga', 'Medicamento descontinuado para ser excluído.'); -- Alvo do DELETE

-- 2. Entidades com dependências
INSERT INTO Funcionario (id_funcionario, nome, cargo, cpf, telefone, email, id_hospital) VALUES
(1, 'Roberto Lima', 'Suporte Técnico', '111.222.333-44', '(11) 91111-2222', 'roberto.lima@hospitalcentral.com', 1), -- Dados antigos para o UPDATE
(2, 'Fernanda Mota', 'Recepcionista', '555.666.777-88', '(11) 98888-9999', 'fernanda.mota@hospitalcentral.com', 1),
(3, 'Jorge Almeida', 'Enfermeiro Chefe', '999.888.777-66', '(81) 95555-4444', 'jorge.almeida@hospitalnorte.com', 2);

INSERT INTO Ambulancia (id_ambulancia, placa, modelo, ano, id_hospital) VALUES
(1, 'XYZ-1234', 'Mercedes-Benz Sprinter', 2015, 1), -- Alvo do DELETE
(2, 'ABC-9876', 'Renault Master', 2022, 1);

INSERT INTO FichaMedica (id_paciente, hist_clinico, alergias, observacoes) VALUES
(1, 'Hipertenso, faz uso de medicação contínua.', 'Dipirona', 'Monitorar pressão arterial em todas as consultas.'),
(2, 'Histórico de asma na infância.', 'Ibuprofeno', 'Paciente responde bem a tratamentos convencionais.'), -- Alergia antiga para o UPDATE
(3, 'Nenhum histórico clínico relevante.', NULL, NULL),
(4, 'Diabetes Tipo 1.', 'Nenhuma conhecida', 'Necessita de controle glicêmico regular.');

INSERT INTO Internacao (id_internacao, data_inicio, data_fim, motivo, id_paciente, id_leito) VALUES
(1, '2025-09-25 14:30:00', NULL, 'Observação pós-cirúrgica cardíaca.', 1, 1), -- Internação para o UPDATE de alta
(2, '2025-09-28 20:00:00', NULL, 'Insuficiência respiratória aguda.', 4, 2); -- Internação extra para a consulta de UTI

INSERT INTO Visita (id_visita, data, observacao, id_paciente) VALUES
(1, '2025-09-29 16:00:00', 'Visita agendada de familiar (filho).', 1), -- Alvo do DELETE
(2, '2025-09-30 15:30:00', 'Visita de amigo.', 4);

-- 3. Tabelas de relacionamento e eventos
INSERT INTO Medico_Hospital (id_medico, id_hospital) VALUES
(1, 1), -- Alvo do DELETE
(1, 2), -- Dr. Carlos também trabalha em outro hospital
(2, 1),
(3, 2);

INSERT INTO Consulta (id_consulta, data, hora, diagnostico_geral, id_paciente, id_medico) VALUES
(1, '2025-09-20', '10:00:00', 'Checagem de rotina e acompanhamento.', 1, 1), -- Base para a consulta completa do paciente 1
(2, '2025-09-21', '11:00:00', 'Acompanhamento cardiológico.', 1, 1),
(3, '2025-09-22', '09:30:00', 'Sintomas de virose.', 2, 2),
(4, '2025-09-23', '14:00:00', 'Dor no joelho direito após esforço.', 3, 3),
(5, '2025-09-24', '16:00:00', 'Consulta de rotina para controle de diabetes.', 4, 2),
(6, '2025-09-25', '08:00:00', 'Avaliação pré-operatória.', 1, 1); -- Mais consultas para o Dr. Carlos para o ranking

-- 4. Dados dependentes de eventos (Consulta -> Exame -> Diagnóstico -> Receita)
INSERT INTO Exame (id_exame, tipo_exame, data, tipo_resultado, id_consulta) VALUES
(1, 'Eletrocardiograma', '2025-09-20 10:15:00', 'Resultados normais', 1);

INSERT INTO Diagnostico (id_diagnostico, descricao_med, data, id_exame) VALUES
(1, 'Paciente estável, manter medicação para hipertensão.', '2025-09-20 11:00:00', 1);

INSERT INTO Receita (id_receita, dosagem, frequencia, duracao, id_diagnostico, id_medicamento) VALUES
(1, '1 comprimido (20mg)', '1 vez ao dia, à noite', 'Uso contínuo', 1, 1);