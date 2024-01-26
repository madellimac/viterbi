# Viterbi

Ce dépôt est le résultat du travail de L. Clairet, T. Guittet, T. Le Mestre et d'A. Veyssière dans le cadre des projets avancés en Systèmes Embarqués de Troisième année à l'Enseirb-Matmeca.

Ce projet a été encadré par Camille Leroux et certains des fichiers ont été réalisés par lui.

L'objectif de ce projet était de pouvoir implémenter sur carte FPGA un décodeur Viterbi fonctionnel et de pouvoir l'utiliser conjointement avec le logiciel `aff3ct` afin de comparer et de s'assurer du fonctionnement du décodage matériel et logiciel d'un message aléatoire ou non.

## Tutoriels
Ce dépôt git est partagé en 2 parties :
- Une partie logicielle. Celle si se base sur l'utilisation de `py_aff3ct`. Un tutoriel sur l'installation du logiciel, son utilisation ainsi que la création de nouveaux modules Python peut être retouvé [ici](./doc/SOFTWARE.md).
- Une partie matérielle. Une explication sur la mise en place du décodage matériel et de la communication UART peut être retrouvée [par là](./doc/HARDWARE.md).