from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [Extension("Tester_Main", ["Tester_Main.pyx"])]

setup(
    ext_modules = cythonize(extensions, language_level=3),
)