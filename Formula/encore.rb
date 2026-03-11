class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.55.0"
    checksums = {
        "darwin_arm64" => "d6ee428f63bdfaac930fe14a9fab835edf4d7ef7fc55a4251149a8a276331867",
        "darwin_amd64" => "22af189bf29411621b38b20d51c475ea26b646e20d98db960013c875aec5d624",
        "linux_arm64"  => "c306410c4ce0c697fc2790ba7cf98353b59fc2999a534d5138883ed2518b615c",
        "linux_amd64"  => "2cfdedd3c339dc834a80de0ea3e4f090852dacc537951a51eb9936da39e5bf36",
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
