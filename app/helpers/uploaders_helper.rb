module UploadersHelper

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    unless model.instance_variable_get(media_original_filenames_var)
      model.instance_variable_set(media_original_filenames_var, {})
    end

    unless model.instance_variable_get(media_original_filenames_var).map{|k,v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({"#{original_filename}": SecureRandom.uuid})
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end
end
