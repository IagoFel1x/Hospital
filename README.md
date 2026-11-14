# Hospital — Banco de Dados

Modelo relacional em **MySQL 8** para um sistema hospitalar de registro de consultas e exames dos pacientes. A implementação em Java que usa este banco está em [HospitalSys](https://github.com/IagoFel1x/HospitalSys).

## Arquivos

| Arquivo | Conteúdo |
|---------|----------|
| `SistemHospital/Hospital_DB.sql` | Criação do banco `hospital_db` e de todas as tabelas |
| `SistemHospital/Hospital_DB_Populacao.sql` | Dados de exemplo |
| `SistemHospital/Hospital_DB_Consultas.sql` | 5 SELECTs, 4 UPDATEs e 4 DELETEs comentados |

## Modelo de dados

- **Estrutura hospitalar:** `Hospital`, `Ambulancia`, `Funcionario`, `Leito`
- **Pacientes:** `Paciente`, `FichaMedica` (1:1), `Internacao`, `Visita`, `PlanoDeSaude` (SUS ou Particular) e `Paciente_PlanoDeSaude`
- **Atendimento clínico:** `Medico`, `Consulta`, `Triagem`, `Exame`, `Diagnostico`, `Medicamento`, `Receita`
- **Relacionamentos N:N:** `Medico_Hospital`, `Medico_Paciente`

Fluxo clínico principal: **Paciente → Triagem → Consulta → Exame → Diagnóstico → Receita (Medicamento)**.

`Triagem.id_consulta` é opcional: uma triagem de pronto atendimento pode existir antes de virar consulta.

## Como usar

Execute os scripts na ordem abaixo:

```bash
mysql -u root -p < SistemHospital/Hospital_DB.sql
mysql -u root -p < SistemHospital/Hospital_DB_Populacao.sql
mysql -u root -p < SistemHospital/Hospital_DB_Consultas.sql
```

> Atenção: `Hospital_DB.sql` começa com `DROP DATABASE IF EXISTS hospital_db;` e apaga o banco existente.

## Próximos passos

- Definir `ON DELETE`/`ON UPDATE` nas chaves estrangeiras conforme a regra de negócio (hoje o padrão `RESTRICT` impede apagar registros referenciados).
- Normalizar `Leito.status` e `PlanoDeSaude.tipo` em tabelas de domínio, se o sistema crescer.

## Autor

[Iago Cordeiro Felix](https://github.com/IagoFel1x)
