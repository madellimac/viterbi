# Fonctionnement des programmes et modules

## Modules 
### conv_encoder
Ce module correspond à l'encodeur des bits du message. Les arrays `poly1` et `poly2` correspondent aux polynômes utilisés pour l'encodage des bits.

### quantizer
Ce module permet de quantifier les données reçues après démodulation.

### viterbi_decoder
Ce module est le décodeur implémentant l'algorithme de Viterbi pour calculer les chemins survivants et donc décoder le message reçu avec le moins d'erreur possible.

Le décodage réalisé dans ce module dépend entièrement de la manière dont les données sont encodées avant d'être envoyées.

Le module calcule d'abord les métriques de branches de tous les états. Ensuite, pour chaque étape, les métriques de nœuds et les chemins sont calculés. Enfin, les états sont remontés en suivant le chemin le plus probable décodant ainsi le message.

### viterbi_splitter
Ce module permet de supprimer les bits en queue du message envoyé qui permettent d'assurer la convergence de l'algorithme sur les valeurs décodées des messages envoyées. 

### viterbi_serial
Ce module permet d'envoyer les données démodulées vers la carte FPGA et également de recevoir les résultats du décodage matériel. 

Pour envoyer, les données en entrée sont converties en entier et sont positionnées entre 0 et 7 sur 3 bits. La signature d'un bit de message est envoyé en une trame de 8 bits. 

Ce module n'a pas été correctement testé avec la partie matérielle et n'envoie sûrement pas les données comme attendu par la carte.

## Programmes
### viterbi
Ce programme permet de simuler la transmission de message avec l'encodeur et le décodeur logiciel. Le module `monitor` de la librairie `py_aff3ct` est utilisé afin d'évaluer le taux d'erreur binaire et de trame pour différentes valeurs de rapport signal à bruit.

Les valeurs de taux d'erreurs sont affichés dans un graphique à la fin de la simulation.

### viterbi_test_uart
Ce programme est un simple programme de test d'envoi et réception de données vers la carte FPGA.

Un message connu est généré avant d'être envoyé à l'encodeur logiciel et matérielle via liaison série. 

Ce programme n'a jamais pu être correctement testé et ne fonctionne certainement pas comme attendu avec la carte FPGA. L'idée était de vérifier une première fois manuellement la cohérence des valeurs au sein du FPGA et les valeurs du décodeur logiciel.

### serial
Simple script Python utilisé pour tester la communication UART et les FIFOs de la carte FPGA.
