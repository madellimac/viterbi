# Installation de la librairie py_aff3ct

### Informations générales
Les commandes fournies dans ce document peuvent varier d'une distribution Linux à une autre. Il convient d'utiliser les commandes adaptées à votre distribution (remplacer `apt` par `dnf` par exemple). `py_aff3ct` peut également être installé sur MacOS et aussi sur Windows par l'intermédiaire de MinGW, sur ces plateformes l'installation peut être différente de celle présentée ici. 

### Prérequis
Python est nécessaire pour pouvoir installer et utiliser `py_aff3ct`, la première étape consiste à installer Python sur votre machine ainsi qu'un gestionnaire de paquets Python. Le générateur de documentation logicielle Doxygen est aussi nécessaire :

```bash
sudo apt install python3 python3-pip doxygen
```

### Installation de la librarie aff3ct

Ensuite, clonez le projet Git de `py_aff3ct` et rentrez dans le dossier `py_aff3ct`:

```bash    
git clone https://github.com/aff3ct/py_aff3ct.git && cd py_aff3ct
```

`py_aff3ct` dépend des projets `aff3ct` et `py_bind11` qu'il convient de télécharger également :

```bash
git submodule update --init --recursive
```

La libraire `aff3ct` doit ensuite être compilée, en cas d'erreur, suivre les indications [suivantes](#en-cas-derreur-%C3%A0-la-compilation) :

```bash
cd lib/aff3ct
mkdir build && cd build
cmake .. -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-funroll-loops -march=native -fvisibility=hidden -fvisibility-inlines-hidden -faligned-new" -DAFF3CT_COMPILE_EXE="OFF" -DAFF3CT_COMPILE_STATIC_LIB="ON" -DAFF3CT_COMPILE_SHARED_LIB="ON"
make -j4
```

La librairie aff3ct est désormais compilée dans le dossier `lib/aff3ct/build`.

Compilez ensuite la documentation avec Doxygen :

```bash
cd ../doc && mkdir build && cd source
doxygen Doxyfile
```

Retournez maintenant dans la racine du projet Git :

```bash
cd ../../../..
```

### Compilation de py_aff3ct
Dans un premier temps, copiez les fichiers de configuration `CMake` du build `aff3ct` :

```bash
mkdir cmake && mkdir cmake/Modules
cp lib/aff3ct/build/lib/cmake/aff3ct-*/* cmake/Modules
```

Compilez maintenant le code :

```bash
mkdir build && cd build
../configure.py --verbose
cmake .. -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-Wall -funroll-loops -march=native -fvisibility=hidden -fvisibility-inlines-hidden -faligned-new"
make -j4
```

La librairie est désormais compilée dans `build/lib/py_aff3ct*.so`.

### Vérification de la compilation
Vérifiez que la compilation s'est bien déroulée en lançant le script de test :

```bash
cd ../examples/full_python
python3 test.py
```

### En cas d'erreur à la compilation
Sur certains systèmes, la compilation échoue. L'un des problèmes les plus courants provient d'une erreur sur les types `uintx_t` qui ne sont pas reconnus par le compilateur. Afin de résoudre le problème, ajoutez la ligne suivante dans les fichiers `lib/aff3ct/src/Tools/Perf/Transpose/transpose_selector.cpp` et `lib/aff3ct/lib/cli/src/Types/File_system/File_system.hpp` :

    #include <stdint>

