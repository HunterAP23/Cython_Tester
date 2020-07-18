from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("Primes.Compiled.Function_Separated.Lambda_LRU", ["Primes/Compiled/Function_Separated/Lambda_LRU.pyx"])]

setup(
    ext_modules = cythonize(extensions, language_level=3),
)