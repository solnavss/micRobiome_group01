setwd("/home/betterlab/GIT/Intro_R")
tab <- read.csv('hsb2demo.csv')
head(tab)

#####cargar librerias####
#install.packages("dplyr")
library("dplyr")
tab <- read.csv('hsb2demo.csv')
head(tab)

tab %>%
select(id,write) %>%
head

#Selecionar columnas con el comando select. De la varaible tab, estamos selecionando id, read, write, math
head(select(tab, id, read, write, math))

#Ahora selecionamos de la tabla ´tab´usando ´select´ desde la columna ´read´a ´socst´
head(select(tab, read:socst))
#Tambien podemos selecionar de la tabla `tab` todas las columnas menos la columna ´female´
head(select(tab, - female))
#De forma similar podemos selecionar las desde que columna a que columna no queremos que aparezcan
head(select(tab, - (female:prog )))

#También podemos selecionar columnas basados en escriterios especificos usando `select`. Estos criterios pueden ser, starts_with(), ends_with(), matches(), contains(), and one_of (). 

# Selecciona todas las columnas que comienzas con el caracter  "s"
head(select(tab, starts_with("s")))


##### Seleccionar filas usando el comando ´filer()´#####
#El comando ´filter()´ permite seleccionar filas de un dataframe.
#Selecting rows using filter()
#Filtra las fila de estudiantes con puntaje de lectura mayor o igual a 70.
filter(tab, read >= 70)


#Filtra las filas de estudiantes con un puntaje de lectura y matematica mayor o igual a 70
filter(tab, read >= 70, math >= 70)

##### Re-ordenar filas usando ´arrange()´#####

#La funcion ´arrange()´ trabaja de manera similar a ´filter()´ solo que este en lugar de selecionar las filas las ordena.

#ordena por read y luego por write
head(arrange(tab, read, write))


#Use desc() para odenar una columna en orden decreciente
head(arrange(tab, desc(read)))

head(arrange(tab, desc(female),read)) #ejemplo

#The pipe operator: %>% can be used with arrange() together.
#Para ejecutar las ordenes por partes
tab %>% arrange(female) %>% head
## Ejemplos con el operador %>% ##
#Selecciona las columnas id, gender, read de tab
#Ordena las filas por gender y luego por read
#Finalmente regresa el head de dataframe resultante
tab%>%select(id, female, read) %>% arrange(female, read) %>%  head

#Filter the rows for read with score greater or equal to 70
tab %>% select(id, female, read) %>% arrange(female, read)


#Arrange the rows for read in a descending order
tab %>% select(id, female, read) %>%   arrange(female, desc(read)) %>% filter(read >= 70)

##### Crear nuevas columnas usando ´mutate()´ #####
#agrega una columna a tab
#Calculate average read and write scores
head(mutate(tab, avg_read = sum(read)/n()))
#To keep only the new variables, use transmute()
head(transmute(tab,avg_read = sum(read)/n()))
 
 #Create new columns using mutate() and pipe operator
tab %>% mutate(avg_read = sum(read/n())) %>%  head


 ##### Valores totales usando ´summarise()´#####
  
#To collapses a data frame to a single row. Calcula la media de la columna read
summarise(tab, avg_read = mean(read, na.rm = TRUE))
avg_read
  
#Create summaries of the data frame using summarise() and pipe operator
tab %>% summarise(avg_read = mean(read),min_read = min(read),max_read = max(read),n = n())

  
##### Agrupando datos usando ´grorup_by#####

#podemos agrupar
#First group by gender, and then get the summary statistics of reading by gender
by_gender <- group_by(tab, female)
read_by_gender <- summarise(by_gender,n = n(), avg_read = mean(read, na.rm = TRUE), min_read = min(read,na.rm = TRUE), max_read = max(read,na.rm = TRUE))
read_by_gender
  