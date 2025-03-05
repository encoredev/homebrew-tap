class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.6"
    checksums = {
        "darwin_arm64" => "d8a2ae68f4ab390317e075aadece4b46236ab46acc01a1a54efa781804924ed6",
        "darwin_amd64" => "5c729d4549f8090d406d05622091473115b9cd0f4c5f4b175947c01798891213",
        "linux_arm64"  => "d9afcc97fbd9f5415ced995fba32a6e5e13699040bc694002fb89507cdb455ac",
        "linux_amd64"  => "b5520a166a20193429b11474cd5e6a1e88240e832a1c4acc42b3f01b4ba16289",
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
