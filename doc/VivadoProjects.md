# Création des projets Vivado

### Projet de test de la communication UART
#### Créer le projet Vivado
À l’aide du logiciel Vivado, créer un nouveau projet avec les fichier suivants :
- `concatenation.sv`
- `uart_tx.sv`
- `uart_rx.sv`
- `fifo.sv`
- `delay.sv`
- `uart_test_alphabet.sv`
- `uart_test_concat.sv`

Mettre en top level:
- soit `uart_test_alphabet.sv` (sans concatenation des données en sortie)
- soit `uart_test_alphabet.sv` (avec concatenation des données en sortie)

Éditer le fichier de contraintes pour :
- L’horloge
- Les LEDs (empty/full FIFO)
- Les switchs (`nreset`, `frome_1rst_to_2ndfifo`, `frome_2nd_to_PC_fifo`)

Générer le bitmap.

Programmer la carte.

#### Envoyer des données à la carte
Ouvrir le script Python `script.py` et le modifier au besoin.

Lancer le script pour l'envoi des données :

```bash
python3 script.py
```

### Projet de décodage Viterbi
#### Créer le projet Vivado
Pour utiliser l'architecture matérielle, il est nécessaire de créer un projet Vivado associé. Cette partie a été testée sur carte Nexys-A7 et sur la version de Vivado installée sur les machines de l'école (2019 ?).

Pour cela, créer un "Projet RTL" et importer les fichiers suivants :

Depuis le dossier `/HW/SV`:
- `decoder_top_level.sv`
- `uart_rx.sv`
- `uart_tx.sv`
- `branch_metric_unit.sv`
- `state_metric_unit.sv`
- `survivor_path.sv`

Depuis le dossier `/HW/VHDL` :
- `viterbi_decoder.vhd`

Une fois cela fait, lancer le projet.

Si cela ne se fait pas automatiquement, définir le `decoder_top_level` comme top level.

Il reste le fichier de contraintes à ajouter : nous fournissons celui pour la carte Nexys-A7-100T que nous avons utilisée, il est sans doute possible d'adapter ce fichier à une autre carte.

Il est alors possible de générer le bitstream et de le mettre sur la carte.

#### Communication avec l'implémentation matérielle

La communication avec l'implémentation matérielle du décodeur Viterbi se fait en RS232 et sa configuration 8N1 à 115200 bauds.

|     Bits      |         0-1         | 2-4  | 5-7  |
|:-------------:|:-------------------:|:----:|:-----|
| Signification | Bits de remplissage | `y1` | `y2` |