 module Books
   class Search < Books::Book
     searchkick

     def search_data
       {
         title: title,
         description: description,
         authors: authors.map(&:name),
         tags: tags.map(&:name),
         created_at: created_at
       }
     end
   end
 end