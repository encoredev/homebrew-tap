class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.8"
    checksums = {
        "darwin_arm64" => "43dd849b6d5b609534e3dbeb29791d3011efc2cee811cde020a5eb27bddf0e5a",
        "darwin_amd64" => "a4a3598fe0efd0a339f7e2934b4536388c31b8875a32200d667610eb4295780f",
        "linux_arm64"  => "4567447527c182ba631d4eba22542dead1797ec2952a7128e308c7d74d865248",
        "linux_amd64"  => "cdc0be57ad3c0e0f0ba7f0ff533a2433b2b41be8a18eb6d19af8b1de75df422b",
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
