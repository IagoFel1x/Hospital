# Hospital — Banco de Dados

Modelo relacional em **MySQL** para um sistema hospitalar de registro de consultas e exames dos pacientes.

## Arquivos

| Arquivo | Conteúdo |
|---------|----------|
| `SistemHospital/Hospital_DB.sql` | Criação do banco `hospital_db` e de todas as tabelas |
| `SistemHospital/Hospital_DB_Populacao.sql` | Dados de exemplo |
| `SistemHospital/Hospital_DB_Consultas.sql` | Consultas SQL de exemplo |

## Modelo de dados

- **Estrutura hospitalar:** `Hospital`, `Ambulancia`, `Funcionario`, `Leito`
- **Pacientes:** `Paciente`, `FichaMedica` (1:1), `Internacao`, `Visita`, `PlanoDeSaude` (SUS ou Particular) e `Paciente_PlanoDeSaude`
- **Atendimento clínico:** `Medico`, `Consulta`, `Triagem`, `Exame`, `Diagnostico`, `Medicamento`, `Receita`
- **Relacionamentos N:N:** `Medico_Hospital`, `Medico_Paciente`

Fluxo clínico principal: **Paciente → Consulta → Exame → Diagnóstico → Receita (Medicamento)**.

## Como usar

Execute os scripts na ordem abaixo (MySQL 8+):

```bash
mysql -u root -p < SistemHospital/Hospital_DB.sql
mysql -u root -p < SistemHospital/Hospital_DB_Populacao.sql
mysql -u root -p < SistemHospital/Hospital_DB_Consultas.sql
```

> Atenção: `Hospital_DB.sql` começa com `DROP DATABASE IF EXISTS hospital_db;` e apaga o banco existente.

## Pontos de melhoria

- A tabela `Triagem` não tem chave estrangeira para `Paciente` ou `Consulta`, então os registros ficam desvinculados.
- Considerar `ON DELETE`/`ON UPDATE` nas chaves estrangeiras.

## Projetos relacionados

A implementação em Java está em [HospitalSys](https://github.com/IagoFel1x/HospitalSys).

## Autor

[Iago Cordeiro Felix](https://github.com/IagoFel1x)
