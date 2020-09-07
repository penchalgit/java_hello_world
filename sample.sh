 $ /bin/sh
String folderPath = "/home/ubuntu/java_docker" + "\\" + "Dockerfile"
def list = []
def dir = new File("/home/ubuntu/java_docker")
dir.eachFileRecurse (FileType.FILES) { file ->
  list << file
}
list.each {
println it.findAll() == "8080" // Just files witch include in list "8080" name
}
