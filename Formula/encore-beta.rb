class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1-beta.4"
    checksums = {
        "darwin_arm64" => "b4f08ebec46fd4ac44df8348be501545e4a3c4edb63353038b6aca86687bedd5",
        "darwin_amd64" => "a2dfa52fd418b9124397be556e4fa5b7316e9356619b3c92b980139e2deb14c7",
        "linux_arm64"  => "f877bad9dcd3e770afb991708c58ca8ce1da2c754135ef6503fd2e03c6cf5216",
        "linux_amd64"  => "d3c07e6156c8a838f338d2e8d72819df8482feee316be6454d96f43d1558d260",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
