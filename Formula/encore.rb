class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.22.2"
    checksums = {
        "darwin_arm64" => "b691ee1871f408aec7e52f3d52723f9bcdc7fbec121b7238f4b2a3d7c4cfcf3a",
        "darwin_amd64" => "531b5f959e3cf6895ebde54023bb87728e7170bbd74f8d9a25140c0495534125",
        "linux_arm64"  => "9d6c0df3e7f527803870d1362dc64814db267aea6c71917a914302945ca47e04",
        "linux_amd64"  => "5b9519d98672280e5d7d990611a44d2be9ebc73896b3c14ef6ef0e63bfe1c417",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
