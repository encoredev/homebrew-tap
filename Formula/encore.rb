class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.7"
    checksums = {
        "darwin_arm64" => "f8f2a7d8a9e385a9dcf47b316cd07a3e9a3f9652dc37ac6724d615d991f9a396",
        "darwin_amd64" => "5dfaff546da6b91cf4121f9fbac7650428f0f0e0000b828bbcb9970bfcdc2911",
        "linux_arm64"  => "89f2867345d05c77e260cea6cda52c4f578c31145e52c502df53a4fa67b4f81f",
        "linux_amd64"  => "a34ebace4d1ba021a148ef9e2e1af537d97b970694bffda6792574bf476f2c65",
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
