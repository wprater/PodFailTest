class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    s3_public_key   = 'AWS_KEY'
    s3_secret       = 'AWS_SECRET'

    @s3_client = ELS3Client.alloc.initWithAccessKey(s3_public_key,
                                                    secretAccessKey:s3_secret)

    photo_path = NSBundle.mainBundle.pathForResource('test_photo', ofType:'jpg')
    image_data = NSData.dataWithContentsOfFile(photo_path)
    content_base64_md5 = image_data.MD5HexDigest()
    mime_type = ELS3Client.mimeTypeForFileAtPath(photo_path)

    @s3_client.create_operation_from_data(image_data,
      filename:     'test_photo.jpg',
      content_md5:  content_base64_md5,
      mime_type:    mime_type,
      client_id:    'foobar',
      success: lambda {|operation, response_object| },
      failure: lambda {|operation, error| }
    )

    true
  end
end
