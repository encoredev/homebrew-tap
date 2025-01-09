class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.4"
    checksums = {
        "darwin_arm64" => "d357c13f17e3db7ea88025d7d80fbe1e816f6274a232b26232cd6a57cfa4ad4c",
        "darwin_amd64" => "b7fd786406c2e53c48c02873ba644f27fb96028a9ab88dbd32070f34b3a2361b",
        "linux_arm64"  => "701ccc470aac88ca3722ca09841299bbe92c77e83852194d1dba28b8571f9268",
        "linux_amd64"  => "ca0efed82d81d784a3637a97aee3f4f094b4dd9f98be55c8346b5e7b9f679948",
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
