class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.53.5"
    checksums = {
        "darwin_arm64" => "7da86b0defc7571df499cc7050cc88f8be2b670093f654f49dcc9860d8cc0ecd",
        "darwin_amd64" => "3bfcc371d3dff97c58b20c82c18b301feb494509661cff0df5b2f0479cfad247",
        "linux_arm64"  => "c3300a990ed5ee51a3548b7c91f5e82d83f5b08a0793a67b32929859f8f8d415",
        "linux_amd64"  => "35a5071f752181ecf52d8132e06b880042cf948cf7e958cc95e02b974c2fb4be",
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
