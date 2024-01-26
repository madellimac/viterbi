# Création d'un module Python

La librairie `py_aff3ct` offre la possibilité de créer des modules `aff3ct` permettant de réaliser certaines opérations que l'on peut définir.

Ces modules s'appuient sur l'utilisation de la classe `Py_Module` fournie par la librairie de `py_aff3ct`. Pour créer un nouveau module, il faut d'abord créer un nouveau fichier Python, importer cette classe au début du fichier et créer une nouvelle classe héritée de `Py_Module` portant le nom souhaité :

```python
from py_aff3ct.module.py_module import Py_Module

class viterbi_serial(Py_Module):
```

## Fonction d'initialisation
La première fonction à créer est la fonction d'initialisation (ou constructeur) du module :

```python
def __init__(self, ...):
```

C'est dans cette fonction que les variables de la classe (ou module) sont déclarés. Un appel à la fonction d'initialisation de `Py_Module` est nécessaire ainsi que l'attribution d'un nom au module :

```python
Py_Module.__init__(self)  # Call the aff3ct Py_Module __init__
self.name = "module_name" # Set your module's name
```

## Création d'une tâche
Sans rien d'autre que la fonction d'initialisation, le module ne sert à rien. Il faut alors créer des tâches qui seront réalisées lorsque celles-ci seront appelées.

### Création de la fonction réalisée par la tâche

Les tâches ne sont rien d'autres que des fonctions définies dans la classe `Py_Module` :

```python
def send(self, r_in):

    # Tâche

    return 0
```

Attention, il est important de noter que toutes les tâches d'un module `Py_Module` doivent retourner l'entier 0 à la fin de la tâche sans quoi le module sera inutilisable.

### Ajout de la tâche à l'initialisation

Une fois que la fonction de la tâche est définie et que son contenu est prêt, il faut mettre en place la possibilité d'utiliser cette tâche. Il est alors nécessaire de rajouter quelques lignes dans la fonction d'initialisation du module.

Il faut donc créer la tâche dans le module grâce à la fonction `create_task()` :

```python
t_task = self.create_task("task_name") # create a task for your module
```

### Ajout des entrées/sorties de la tâche
Après avoir créé la tâche, toujours dans la fonction d'initialisation, il faut déclarer ses entrées et ses sorties sous la forme de `sockets`. Comme leur nom l'indique, les fonctions `create_socket_in()` et `create_socket_out()` le permettent :

```python
r_in  = self.create_socket_in (t_task, "nom_in",  nb_element, type)
r_out = self.create_socket_out(t_task, "nom_out", nb_element, type)
```

### Création du codelet
La dernière étape consiste enfin à créer le `codelet` associé à la tâche grâce à la fonction `create_codelet()` dans la fonction d'initialisation :

```python
self.create_codelet(t_task, lambda slf, lsk, fid: slf.task(lsk[r_in], lsk[r_out]))
```

## Utilisation d'un module
Pour utiliser votre module personnalisé dans votre programme, il faut d'abord l'importer :

```python
from module_file import class_module_name
```

Il suffit ensuite de déclarer le module comme vous en auriez l'habitude en Python :

```python
module = class_module_name(...)
```

Enfin, vous pouvez connecter les entrées et les sorties des tâches de vos modules.

Lorsqu'une entrée ou une sortie de votre module ne doit pas être connectée à un autre module, il suffit d'utiliser la fonction `bind()` :

```python
module["task_name::r_in"].bind(input)
```

Si deux modules doivent être interconnectés :

```python
module2["task_name::r_out"] = module1["task_name::r_in"]
```

Enfin, pour exécuter la tâche d'un de vos modules, la fonction `exec()` est utilisée :

```python
module["task_name"].exec()
```

Comme vous l'avez sûrement compris, pour accéder directement aux entrées et sorties d'un module ou bien pour faire référence à une tâche en particulier, des `[]` sont utilisés. À l'intérieur, le nom de la tâche est donnée entre des `""` ou des `''`, suivi, le cas échéant de `::` et le nom de l'entrée/sortie.

## En cas de doute
En cas de doute, le plus simple est d'ouvrir un fichier de module simple comme le module `viterbi_serial` dans le fichier du même nom et d'observer comment sont contruits les modules.