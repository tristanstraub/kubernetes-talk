export JAVA_HOME=/Users/tristanstraub/vendor/graalvm-1.0.0-rc1/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

which java
which native-image

# 1. brainfuck -> graalvm

cd /Users/tristanstraub/projects/tristanstraub/docker-graalvm/bf-graal
mvn package
./bf examples/hello-world.bf
./bf examples/mandelbrot.bf

# 2. clj brainfuck -> graalvm [in new terminal with non-graal jdk]

cd /Users/tristanstraub/projects/tristanstraub/docker-graalvm/clj-bf-graal
boot build

# Run against standard jdk: java -cp $PWD/target/project.jar language.bf ./examples/mandelbrot.bf

# back to graal terminal

java -cp $PWD/target/project.jar -XX:-UseJVMCIClassLoader language.bf ./examples/mandelbrot.bf

# 3. clojure native executable, clojure native shared library, R interop,

/Users/tristanstraub/projects/tristanstraub/docker-graalvm/graal-experiments
make

# Produces libproject.dylib, (linux: libproject.so), main, project

# Open core.clj in repl, demo "R" interop (uncomment truffle-api)
gu -c install org.graalvm.r

boot -i "(require 'cider.tasks)" -d org.clojure/tools.nrepl\:0.2.13 -d refactor-nrepl\:2.4.0-SNAPSHOT -d cider/cider-nrepl\:0.17.0 cider.tasks/add-middleware -m refactor-nrepl.middleware/wrap-refactor -m cider.nrepl/cider-middleware repl -s -H :: wait
