class Article < ActiveRecord::Base
  class Section
    ABOUT_US = 'Acerca de'
    CONTACT_US = 'Contacto'
    INICIO = 'Inicio'
    PSICOLOGIA_CLINICA = 'Psicología Clínica y Psicoterapia'
    CONTROL_MEMORIA = 'Control de Memoria'
    TALLERES_MEMORIA = 'Talleres de Memoria'
    ESTIMULACION_DEMENCIAS = 'Estimulación Cognitiva en Demencias'
    ESTIMULACION_MEMORIA = 'Estimulación Cognitiva y Memoria'
    EST_NEUROPSICOTICOS = 'Estudios Neuropsicológicos'
    GRUPOS_TERAPEUTICOS = 'Grupos Terapéuticos'
    TALLERES_YOGA = 'Talleres de Yoga'
    YOGA = 'Yoga'
  end
  #attr_accessor :body
  def body
    remove_references(remove_images(CGI::unescape(self.content))) unless self.content.blank?
  end
  def body=(html_without_images_and_references)
    html_with_images = add_images(html_without_images_and_references)
    html_with_images_and_references = add_references(html_with_images)
    self.content = CGI::escape(html_with_images_and_references)
  end
  def remove_images(value)
    r = Regexp.new("(<img\sname='([^']*)'([^>])*>)", Regexp::IGNORECASE | Regexp::MULTILINE)
    value.gsub(r) do |match| 
      picture = Picture.find_by_title($2)
      if picture
        url = picture.filename
        alt = picture.description
        "(FOTO=#{picture.title})"
      else
        match
      end
    end
  end
  def remove_references(value)
    r = Regexp.new("(<a\sname='([^']*)'([^>])*>)", Regexp::IGNORECASE | Regexp::MULTILINE)
    value.gsub(r) do |match| 
     reference = ReferenceMaterial.find_by_title($2)
      if reference
        "(MATERIAL=#{reference.title})"
      else
        match
      end
    end
  end
  def add_images(value)
    r = Regexp.new('\(FOTO=(.*)\)', Regexp::IGNORECASE | Regexp::MULTILINE)
    value.gsub(r) do |match| 
      picture = Picture.find_by_title($1)
      if picture
        url = picture.filename
        alt = picture.description
        "<img name='#{picture.title}' src='/images/attachments/#{picture.filename_relative_path}' alt='#{alt}' />"
      else
        match
      end
    end if value
  end
  def add_references(value)
    r = Regexp.new('\(MATERIAL=(.*)\)', Regexp::IGNORECASE | Regexp::MULTILINE)
    value.gsub(r) do |match| 
      reference = ReferenceMaterial.find_by_title($1)
      if reference
        "<a name='#{reference.title}' href='/reference_materials/#{reference.to_param}' />"
      else
        match
      end
    end if value
  end
end
