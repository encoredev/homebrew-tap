class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.30.0"
    checksums = {
        "darwin_arm64" => "cba04dacd6c1c101432b43510eae95e411e8234f86fb01bef147778a46d41c34",
        "darwin_amd64" => "fab3fbe38c760fa24a7c53b0cb610e46159e4796c6365680388405de2fbd0f10",
        "linux_arm64"  => "4277dd5049eddca8d47418233b96ee86692b913bdfda70c8aa1b12ef45e2d646",
        "linux_amd64"  => "7190089c7d734fb1467bba67deaaf33f717253504bec59b14fb727dd69d4080d",
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
