class NSMutableURLRequest
  attr_accessor :client_id
  attr_accessor :s3_key
end

class ELS3Client < AFS3Client

  # TODO Get bucket and store_dir from API
  BUCKET = NSBundle.mainBundle.infoDictionary['ELAWSS3Bucket']
  STORE_DIR = '/uploads'


  def initWithAccessKey(access_key,
                        secretAccessKey: secret_key,
                        sessionToken: session_token)

    registerHTTPOperationClass(AFXMLRequestOperation)
    super
  end

  def initWithAccessKey(access_key, secretAccessKey: secret_key)

    registerHTTPOperationClass(AFXMLRequestOperation)
    super
  end

  def create_operation_from_data(data,
                                 filename: filename,
                                 content_md5: content_md5,
                                 mime_type: mime_type,
                                 client_id: client_id,
                                 success: success_block,
                                 failure: failure_block)
    key = s3_key(filename)
    path = "#{BUCKET}#{key}"

    # The below message prints the error:
    # Objective-C stub for message `buildRequestHeadersForBucket:key:' type `v@:@@' not precompiled. Make sure you properly link with the framework or library that defines this message.
    buildRequestHeadersForBucket(BUCKET, key:key)

    # This message is successful, but is not in my other project.  They are reversed.
    buildRequestHeadersForBucket(BUCKET, key:key, mimeType:mime_type, contentMD5:content_md5)

    request = requestWithMethod('PUT', path:path, data:data)
    request.client_id = client_id
    request.s3_key = key

    operation = HTTPRequestOperationWithRequest(request,
                                                success:success_block,
                                                failure:failure_block)
  end

  # def build_request_headers_for_bucket(bucket, key: key)
  #   dateString = AFS3Client.S3RequestDateFormatter.stringFromDate(NSDate.date)
  #   setDefaultHeader('Date', value:dateString)

  #   # // Ensure our formatted string doesn't use '(null)' for the empty path
  #   canonicalizedResource = "/#{bucket}#{AFS3Client.stringByURLEncodingForS3Path(key)}"

  #   # Add a header for the access policy if one was set, otherwise we won't add one (and S3 will default to private)
  #   canonicalizedAmzHeaders = ''
  #   self.S3Headers.sort.each do |header, val|
  #     canonicalizedAmzHeaders = "#{canonicalizedAmzHeaders}#{header.downcase}:#{val}\n"
  #     setDefaultHeader(header, value:val)
  #   end

  #   # Put it all together
  #   stringToSign = "PUT\n\n#{dateString}\n#{canonicalizedAmzHeaders}\n#{canonicalizedAmzHeaders}#{canonicalizedResource}"
  #   NSLog("aws_secret_key %@", self.aws_secret_key)
  #   signature = AFS3Client.base64forData(AFS3Client.HMACSHA1withKey(aws_secret_key,
  #                                        forString:stringToSign));
  #   authorizationString = "AWS #{_accessKey}:#{signature}"
  #   setDefaultHeader('Authorization', value:authorizationString)
  # end

  # def s3_headers
  #   headers = {}
  #   if _accessPolicy
  #     headers['x-amz-acl'] = _accessPolicy
  #   end
  #   if _sessionToken
  #     headers['x-amz-security-token'] = _sessionToken
  #   end

  #   headers
  # end

  def s3_key(filename)
    # "#{STORE_DIR}/#{BW.create_uuid}/#{filename}"
    "foo"
  end

end
