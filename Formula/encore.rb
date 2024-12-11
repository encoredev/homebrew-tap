class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.1"
    checksums = {
        "darwin_arm64" => "78f2efd14d994a5153bfe1c14711b3d33a93711ff3122cf444dd49c3f30bb4b1",
        "darwin_amd64" => "59fbc037d38b7bb9c846a1a2ed571b42f4c71a76adc186953ff15c97b63e7f81",
        "linux_arm64"  => "8c1a3a40512e82adfa6c6ce48b1adfe64e689b24f2bd7b1dd53992a0b9fab083",
        "linux_amd64"  => "7f80a1d5ba75ea94dbd7b95af7fe805a3d07225500a129012dcfb84a40fcf655",
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
