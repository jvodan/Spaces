require_relative '../resolving/resolution'

def resolution; @resolution ||= universe.resolutions.by(descriptor) ;end

def save_resolution; universe.resolutions.save(resolution) ;end
